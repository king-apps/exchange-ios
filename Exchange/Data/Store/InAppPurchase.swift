import Foundation
import StoreKit
import KingOS


final class InAppPurchase: NSObject {
    
    
    // Product catalog
    enum Product: CaseIterable {
        case premiumOneTime
        case premiumSubscriptionWeekly
        case premiumSubscriptionPromotional
        case premiumSubscriptionMonthly
        case premiumSubscriptionQuarterly
        case premiumSubscriptionSemiannual
        
        var identifier: String {
            switch self {
            case .premiumOneTime:
                return InAppPurchase.shared.identifier(for: self)
            case .premiumSubscriptionWeekly:
                return InAppPurchase.shared.identifier(for: self)
            case .premiumSubscriptionPromotional:
                return InAppPurchase.shared.identifier(for: self)
            case .premiumSubscriptionMonthly:
                return InAppPurchase.shared.identifier(for: self)
            case .premiumSubscriptionQuarterly:
                return InAppPurchase.shared.identifier(for: self)
            case .premiumSubscriptionSemiannual:
                return InAppPurchase.shared.identifier(for: self)
            }
        }
    }
    
    enum InAppPurchaseError: LocalizedError {
        case paymentsDisabled
        case noProductIdentifiersConfigured
        case requestFailed
        case noProductsFound
        case productNotFound
        case purchaseFailed
        case purchaseCancelled
        case restoreFailed
        
        var errorDescription: String? {
            switch self {
            case .paymentsDisabled:
                return "Payments are disabled on this device."
            case .noProductIdentifiersConfigured:
                return "No StoreKit product identifiers were configured."
            case .requestFailed:
                return "Failed to load products from the App Store."
            case .noProductsFound:
                return "No products were found."
            case .productNotFound:
                return "Product not found."
            case .purchaseFailed:
                return "Purchase failed."
            case .purchaseCancelled:
                return "Purchase cancelled."
            case .restoreFailed:
                return "Restore failed."
            }
        }
    }
    
    
    // Singleton
    static let shared = InAppPurchase()
    
    
    // Persistence
    private enum Key {
        static let isPremium = "Store.IsPremium"
    }
    
    
    // State
    private var isObserving = false
    private var productsByIdentifier: [String: SKProduct] = [:]
    private let identifiersLock = NSLock()
    private var identifiersByProduct: [Product: String] = [:]
    
    private var requestsByObjectID: [ObjectIdentifier: SKProductsRequest] = [:]
    private var requestCompletions: [ObjectIdentifier: (Result<[SKProduct], InAppPurchaseError>) -> Void] = [:]
    private var singleRequestCompletions: [ObjectIdentifier: (SKProduct?) -> Void] = [:]
    
    private var purchaseCompletion: ((Result<Bool, Error>) -> Void)?
    private var purchaseGrantsPremium = true
    private var restoreCompletion: ((Result<[Product], Error>) -> Void)?
    
    
    // Init
    private override init() {
        super.init()
        identifiersByProduct = Self.emptyIdentifiersByProduct()
    }
    
    
    // Lifecycle
    func start() {
        guard isObserving == false else { return }
        isObserving = true
        SKPaymentQueue.default().add(self)
    }
    
    func stop() {
        guard isObserving else { return }
        isObserving = false
        SKPaymentQueue.default().remove(self)
    }
    
    
    // Status
    func isPremium() -> Bool {
        if AppPreviewMode.forcePremium {
            return true
        }
        return UserDefaults.standard.bool(forKey: Key.isPremium)
    }

    func refreshPremiumStatus(completion: @escaping(_ isPremium: Bool) -> Void) {
        if AppPreviewMode.forcePremium {
            completion(true)
            return
        }
        
        if #available(iOS 15.0, *) {
            Task {
                let isPremium = await fetchPremiumStatusFromStoreKit()
                await MainActor.run {
                    self.setPremium(isPremium)
                    completion(isPremium)
                }
            }
        } else {
            let isPremium = isPremium()
            completion(isPremium)
        }
    }

    func resetCachedPremiumStatus() {
        setPremium(false)
    }
    
    func configureIdentifiers(from catalog: KingOSIAPCatalog?) {
        identifiersLock.lock()
        defer { identifiersLock.unlock() }
        
        identifiersByProduct = Self.emptyIdentifiersByProduct()
        
        guard let catalog else {
            return
        }
        
        for offer in catalog.offers where offer.storeProductId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            if Self.isOneTimePremiumIdentifier(offer.storeProductId) {
                identifiersByProduct[.premiumOneTime] = offer.storeProductId
                continue
            }
            
            switch offer.key {
            case .weekly:
                identifiersByProduct[.premiumSubscriptionWeekly] = offer.storeProductId
            case .promotional:
                identifiersByProduct[.premiumSubscriptionPromotional] = offer.storeProductId
            case .monthly:
                identifiersByProduct[.premiumSubscriptionMonthly] = offer.storeProductId
            case .quarterly:
                identifiersByProduct[.premiumSubscriptionQuarterly] = offer.storeProductId
            case .semiannual:
                identifiersByProduct[.premiumSubscriptionSemiannual] = offer.storeProductId
            case .bimonthly, .annual:
                continue
            }
        }
    }
    
    
    // Product requests
    func requestSubscriptions(completion: @escaping(_ products: [SKProduct]?, _ error: String?) -> Void) {
        let configuredIdentifiers = Product.allCases
            .map(\.identifier)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        #if DEBUG
        print("StoreKit configured subscription identifiers: \(configuredIdentifiers)")
        #endif
        request(products: Product.allCases, completion: completion)
    }
    
    func request(products: [Product], completion: @escaping(_ products: [SKProduct]?, _ error: String?) -> Void) {
        let ids = Set(
            products
                .map { $0.identifier.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
        )
        
        request(productIdentifiers: Array(ids), completion: completion)
    }
    
    func request(productIdentifiers: [String], completion: @escaping(_ products: [SKProduct]?, _ error: String?) -> Void) {
        let ids = Set(
            productIdentifiers
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
        )
        
        guard ids.isEmpty == false else {
            completion(nil, InAppPurchaseError.noProductIdentifiersConfigured.localizedDescription)
            return
        }
        
        #if DEBUG
        print("StoreKit request identifiers: \(Array(ids).sorted())")
        #endif
        
        let request = SKProductsRequest(productIdentifiers: ids)
        let objectID = ObjectIdentifier(request)
        
        requestsByObjectID[objectID] = request
        requestCompletions[objectID] = { result in
            switch result {
            case .success(let products):
                completion(products, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
        request.delegate = self
        request.start()
    }
    
    func request(product: Product, completion: @escaping(_ product: SKProduct?) -> Void) {
        let identifier = product.identifier.trimmingCharacters(in: .whitespacesAndNewlines)
        guard identifier.isEmpty == false else {
            completion(nil)
            return
        }
        
        if let cached = productsByIdentifier[identifier] {
            completion(cached)
            return
        }
        
        let request = SKProductsRequest(productIdentifiers: [identifier])
        let objectID = ObjectIdentifier(request)
        
        requestsByObjectID[objectID] = request
        singleRequestCompletions[objectID] = completion
        
        request.delegate = self
        request.start()
    }
    
    
    // Purchasing
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func purchase(product: SKProduct, grantsPremium: Bool = true, completion: @escaping(_ result: Result<Bool, Error>) -> Void) {
        guard canMakePayments() else {
            completion(.failure(InAppPurchaseError.paymentsDisabled))
            return
        }
        
        purchaseGrantsPremium = grantsPremium
        purchaseCompletion = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func purchaseConsumable(product: SKProduct, completion: @escaping(_ result: Result<Bool, Error>) -> Void) {
        purchase(product: product, grantsPremium: false, completion: completion)
    }
    
    func restore(completion: @escaping(_ result: Result<[Product], Error>) -> Void) {
        restoreCompletion = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    // Internal
    func identifier(for product: Product) -> String {
        identifiersLock.lock()
        defer { identifiersLock.unlock() }
        return identifiersByProduct[product] ?? ""
    }

    func handleProductsResponse(_ response: SKProductsResponse, for request: SKProductsRequest) {
        let objectID = ObjectIdentifier(request)
        let products = response.products
        let invalidProductIdentifiers = response.invalidProductIdentifiers

        if invalidProductIdentifiers.isEmpty == false {
            #if DEBUG
            print("StoreKit invalidProductIdentifiers: \(invalidProductIdentifiers)")
            #endif
        }
        #if DEBUG
        print("StoreKit validProductIdentifiers: \(products.map { $0.productIdentifier })")
        #endif
        
        for product in products {
            productsByIdentifier[product.productIdentifier] = product
        }
        
        if let completion = requestCompletions.removeValue(forKey: objectID) {
            completion(products.isEmpty ? .failure(.noProductsFound) : .success(products))
        }
        
        if let singleCompletion = singleRequestCompletions.removeValue(forKey: objectID) {
            singleCompletion(products.first)
        }
        
        requestsByObjectID.removeValue(forKey: objectID)
    }
    
    func handleProductsRequestFailure(for request: SKRequest) {
        guard let productsRequest = request as? SKProductsRequest else { return }
        let objectID = ObjectIdentifier(productsRequest)
        
        if let completion = requestCompletions.removeValue(forKey: objectID) {
            completion(.failure(.requestFailed))
        }
        
        if let singleCompletion = singleRequestCompletions.removeValue(forKey: objectID) {
            singleCompletion(nil)
        }
        
        requestsByObjectID.removeValue(forKey: objectID)
    }
    
    func handlePurchaseFinished(success: Bool, error: Error? = nil) {
        if success {
            if purchaseGrantsPremium {
                setPremium(true)
            }
            purchaseCompletion?(.success(true))
        }
        else if let error {
            purchaseCompletion?(.failure(error))
        }
        else {
            purchaseCompletion?(.failure(InAppPurchaseError.purchaseFailed))
        }
        
        purchaseCompletion = nil
        purchaseGrantsPremium = true
    }
    
    func handleRestoreFinished(with identifiers: [String]) {
        let restoredProducts = identifiers.compactMap { Product.from(identifier: $0) }
        let hasPremium = identifiers.contains { Product.isPremiumIdentifier($0) }
        
        if hasPremium {
            setPremium(true)
        }
        restoreCompletion?(.success(restoredProducts))
        restoreCompletion = nil
    }
    
    func handleRestoreFailure(_ error: Error? = nil) {
        restoreCompletion?(.failure(error ?? InAppPurchaseError.restoreFailed))
        restoreCompletion = nil
    }
    
    private func setPremium(_ value: Bool) {
        let defaults = UserDefaults.standard
        let oldValue = defaults.bool(forKey: Key.isPremium)
        
        defaults.set(value, forKey: Key.isPremium)
        defaults.synchronize()
        
        if oldValue != value {
            NotificationCenter.default.post(name: .reloadMatchMaker, object: nil)
            NotificationCenter.default.post(name: .reloadProductList, object: nil)
            NotificationCenter.default.post(name: .reloadChatList, object: nil)
            NotificationCenter.default.post(name: .reloadProfile, object: nil)
        }
    }
    
    private static func emptyIdentifiersByProduct() -> [Product: String] {
        [
            .premiumOneTime: "",
            .premiumSubscriptionWeekly: "",
            .premiumSubscriptionPromotional: "",
            .premiumSubscriptionMonthly: "",
            .premiumSubscriptionQuarterly: "",
            .premiumSubscriptionSemiannual: ""
        ]
    }
    
}


@available(iOS 15.0, *)
private extension InAppPurchase {
    func fetchPremiumStatusFromStoreKit() async -> Bool {
        for await entitlement in StoreKit.Transaction.currentEntitlements {
            guard case .verified(let transaction) = entitlement else {
                continue
            }

            if transaction.revocationDate != nil {
                continue
            }

            if let expirationDate = transaction.expirationDate, expirationDate <= Date() {
                continue
            }

            return true
        }

        return false
    }
}


private extension InAppPurchase.Product {
    static func from(identifier: String) -> InAppPurchase.Product? {
        return Self.allCases.first { $0.identifier == identifier }
    }
    
    static func isPremiumIdentifier(_ identifier: String) -> Bool {
        return Self.allCases.contains { product in
            switch product {
            case .premiumOneTime,
                    .premiumSubscriptionWeekly,
                    .premiumSubscriptionPromotional,
                    .premiumSubscriptionMonthly,
                    .premiumSubscriptionQuarterly,
                    .premiumSubscriptionSemiannual:
                return product.identifier == identifier
            }
        }
    }
}


private extension InAppPurchase {
    static func isOneTimePremiumIdentifier(_ identifier: String) -> Bool {
        let normalized = identifier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return normalized == "exchange.stickers.premium"
            || (normalized.hasSuffix(".premium") && !normalized.contains(".subscription."))
    }
}


extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }
}
