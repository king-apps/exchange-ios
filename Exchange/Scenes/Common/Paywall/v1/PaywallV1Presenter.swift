//
//  PaywallV1Presenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit
import KingOS


protocol PaywallV1PresentationLogic {
    func load(response: PaywallV1.Load.Response)
    func AB(response: PaywallV1.AB.Response)
    func fetch(response: PaywallV1.Fetch.Response)
    func purchase(response: PaywallV1.Purchase.Response)
    func restore(response: PaywallV1.Restore.Response)
}


class PaywallV1Presenter: PaywallV1PresentationLogic {
    
    private enum ABPayloadKey {
        static let cta = "cta"
        static let description = "description"
        static let product = "product"
        static let productHighlighted = "product_highlighted"
        static let productTag = "product_tag"
    }
    
    private enum LogMessage {
        static let fetchError = "Paywall fetch error"
        static let fetchedProductIdentifiers = "Paywall fetched product identifiers"
        static let renderedProductIdentifiers = "Paywall rendered product identifiers"
        static let selectedProductIdentifier = "Paywall selected/highlighted product identifier"
    }
  
    
    // Var's
    weak var viewController: PaywallV1DisplayLogic?
  
    
    // Handler load
    func load(response: PaywallV1.Load.Response) {
        
        var rows: [MainTableRow] = []
        
        rows.append(
            .loading(
                .init(height: 300)
            )
        )
        
        let viewModel = PaywallV1.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler AB
    func AB(response: PaywallV1.AB.Response) {
        
        let viewModel = PaywallV1.AB.ViewModel(
            abAssignment: response.abAssignment
        )
        viewController?.onAB(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: PaywallV1.Fetch.Response) {
        
        var rows = [MainTableRow]()
        var productIdentifiersByRow = [Int: String]()
        var productsByIdentifier = [String: SKProduct]()
        let offerKeyByIdentifier = Dictionary(
            uniqueKeysWithValues: (response.catalog?.offers ?? []).map { ($0.storeProductId, $0.key) }
        )
        

        if let cta = response.abAssignment?.payloadString(ABPayloadKey.cta) {
            rows.append(.spacing(.init(size: .sm)))
            rows.append(
                .textHeadingMd(
                    .init(
                        text: cta
                    )
                )
            )
            if let description = response.abAssignment?.payloadString(ABPayloadKey.description) {
                rows.append(
                    .textBodySmall(
                        .init(
                            text: description
                        )
                    )
                )
                
            }
            rows.append(.spacing(.init(size: .xl)))
        }
        
        
        let products = sortProducts(response.products, catalog: response.catalog)
        let selectedProductIdentifier = selectedProductIdentifier(
            products: products,
            catalog: response.catalog,
            abAssignment: response.abAssignment
        )
        if let error = response.error, products.isEmpty {
            #if DEBUG
            print("\(LogMessage.fetchError): \(error)")
            #endif
            rows.append(
                .textBodySmall(
                    .init(
                        text: error
                    )
                )
            )
        }
        else {
            let hasOneTimeProducts = products.contains(where: isOneTimePremium)
            let hasSubscriptionProducts = products.contains { !isOneTimePremium($0) }
            
            for (index, product) in products.enumerated() {
                if shouldInsertOneTimeCaption(
                    before: product,
                    at: index,
                    products: products,
                    hasOneTimeProducts: hasOneTimeProducts
                ) {
                    rows.append(
                        .textCaption(
                            .init(
                                icon: .none,
                                text: "PayWall.Section.OneTime".localized,
                                align: .left,
                                color: AppTheme.Colors.neutral400
                            )
                        )
                    )
                    rows.append(.spacing(.init(size: .xxs)))
                }
                
                if shouldInsertSubscriptionCaption(
                    before: product,
                    at: index,
                    products: products,
                    hasOneTimeProducts: hasOneTimeProducts,
                    hasSubscriptionProducts: hasSubscriptionProducts
                ) {
                    rows.append(.spacing(.init(size: .lg)))
                    rows.append(
                        .textCaption(
                            .init(
                                icon: .none,
                                text: "PayWall.Section.Subscription".localized,
                                align: .left,
                                color: AppTheme.Colors.neutral400
                            )
                        )
                    )
                    rows.append(.spacing(.init(size: .xxs)))
                }
                
                let rowIndex = rows.count
                productIdentifiersByRow[rowIndex] = product.productIdentifier
                productsByIdentifier[product.productIdentifier] = product
                
                rows.append(
                    .default(
                        .init(
                            iconLeft: .none,
                            iconRight: isHighlighted(product, selectedProductIdentifier: selectedProductIdentifier) ? .checkCircle : .circle,
                            title: localizedTitle(for: product),
                            titleNumberOfLines: nil,
                            description: localizedDescription(for: product, catalog: response.catalog),
                            style: isHighlighted(product, selectedProductIdentifier: selectedProductIdentifier) ? .selected : .normal,
                            identifier: .payWall,
                            tag: tagModel(for: product, products: products, catalog: response.catalog, abAssignment: response.abAssignment)
                        )
                    )
                )

                if index < products.count - 1 {
                    rows.append(.spacing(.init(size: .xxs)))
                }
            }
        }
        
        #if DEBUG
        print("\(LogMessage.fetchedProductIdentifiers): \(products.map { $0.productIdentifier })")
        print("\(LogMessage.renderedProductIdentifiers): \(Array(productIdentifiersByRow.values))")
        print("\(LogMessage.selectedProductIdentifier): \(String(describing: selectedProductIdentifier))")
        #endif
        
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textCaption(
                .init(
                    text: captionText(for: products.first(where: { $0.productIdentifier == selectedProductIdentifier })),
                    color: AppTheme.Colors.neutral400
                )
            )
        )
        rows.append(.spacing(.init(size: .lg)))
        
        let viewModel = PaywallV1.Fetch.ViewModel(
            rows: rows,
            productsByIdentifier: productsByIdentifier,
            productIdentifierByRow: productIdentifiersByRow,
            selectedProductIdentifier: selectedProductIdentifier,
            offerKeyByIdentifier: offerKeyByIdentifier
        )
        viewController?.onFetch(viewModel: viewModel)
    }
    
    func purchase(response: PaywallV1.Purchase.Response) {
        let viewModel: PaywallV1.Purchase.ViewModel
        
        if response.success {
            viewModel = .init(
                title: "PayWall.Purchase.Success.Title".localized,
                message: "PayWall.Purchase.Success.Message".localized,
                shouldDismiss: true
            )
        }
        else {
            viewModel = .init(
                title: "Alert.Title.Warning".localized,
                message: response.error ?? InAppPurchase.InAppPurchaseError.purchaseFailed.localizedDescription,
                shouldDismiss: false
            )
        }
        
        viewController?.onPurchase(viewModel: viewModel)
    }
    
    func restore(response: PaywallV1.Restore.Response) {
        let viewModel: PaywallV1.Restore.ViewModel
        
        if let error = response.error {
            viewModel = .init(
                title: "Alert.Title.Warning".localized,
                message: error,
                shouldDismiss: false
            )
        }
        else {
            viewModel = .init(
                title: "PayWall.Restore.Success.Title".localized,
                message: "PayWall.Restore.Success.Message".localized,
                shouldDismiss: true
            )
        }
        
        viewController?.onRestore(viewModel: viewModel)
    }

    private func sortProducts(_ products: [SKProduct], catalog: KingOSIAPCatalog?) -> [SKProduct] {
        products.sorted { lhs, rhs in
            rank(for: lhs.productIdentifier, catalog: catalog) < rank(for: rhs.productIdentifier, catalog: catalog)
        }
    }

    private func rank(for identifier: String, catalog: KingOSIAPCatalog?) -> Int {
        if let offer = catalog?.offers.first(where: { $0.storeProductId == identifier }) {
            if InAppPurchase.Product.premiumOneTime.identifier == identifier || isOneTimePremiumIdentifier(identifier) {
                return 0
            }
            
            switch offer.key {
            case .promotional:
                return 1
            case .weekly:
                return 2
            case .monthly:
                return 3
            case .bimonthly:
                return 4
            case .quarterly:
                return 5
            case .semiannual:
                return 6
            case .annual:
                return 7
            }
        }
        
        switch identifier {
        case InAppPurchase.Product.premiumOneTime.identifier:
            return 0
        case InAppPurchase.Product.premiumSubscriptionWeekly.identifier:
            return 2
        case InAppPurchase.Product.premiumSubscriptionPromotional.identifier:
            return 1
        case InAppPurchase.Product.premiumSubscriptionMonthly.identifier:
            return 3
        case InAppPurchase.Product.premiumSubscriptionQuarterly.identifier:
            return 5
        case InAppPurchase.Product.premiumSubscriptionSemiannual.identifier:
            return 6
        default:
            return 99
        }
    }

    private func isHighlighted(_ product: SKProduct, selectedProductIdentifier: String?) -> Bool {
        product.productIdentifier == selectedProductIdentifier
    }

    private func localizedPrice(for product: SKProduct) -> String {
        product.price.doubleValue.moneyFormatWithCurrencySimbol(locale: product.priceLocale)
    }
    
    private func localizedTitle(for product: SKProduct) -> String {
        if isOneTimePremium(product) {
            return localizedPrice(for: product)
        }
        
        if let introductoryPrice = product.introductoryPrice,
           introductoryPrice.paymentMode == .freeTrial {
            return "PayWall.Intro.FreeTrial.Highlight".localized
                .replacingOccurrences(of: "{$0}", with: localizedPeriod(introductoryPrice.subscriptionPeriod))
        }
        
        return localizedPrice(for: product)
    }

    private func localizedDescription(for product: SKProduct, catalog: KingOSIAPCatalog?) -> String {
        if isOneTimePremium(product) {
            return "PayWall.Period.OneTime.2026".localized
        }
        
        if let introductoryDescription = introductoryDescription(for: product) {
            return introductoryDescription
        }

        if let semanticTitle = localizedSemanticPeriod(for: product, catalog: catalog) {
            return semanticTitle
        }

        if let period = product.subscriptionPeriod {
            return localizedPeriod(period)
        }

        return product.localizedTitle
    }
    
    private func introductoryDescription(for product: SKProduct) -> String? {
        guard let introductoryPrice = product.introductoryPrice else { return nil }
        
        switch introductoryPrice.paymentMode {
        case .freeTrial:
            return freeTrialRenewalText(
                for: product,
                renewalPeriod: product.subscriptionPeriod,
                renewalPrice: localizedPrice(for: product)
            )
        case .payAsYouGo, .payUpFront:
            return "PayWall.Intro.PricePeriod".localized
                .replacingOccurrences(of: "{$0}", with: introductoryPrice.localizedPrice)
                .replacingOccurrences(of: "{$1}", with: localizedPeriod(introductoryPrice.subscriptionPeriod))
        @unknown default:
            return nil
        }
    }
    
    private func freeTrialRenewalText(
        for product: SKProduct,
        renewalPeriod: SKProductSubscriptionPeriod?,
        renewalPrice: String
    ) -> String {
        guard let renewalPeriod else {
            return renewalPrice
        }
        
        return "PayWall.Intro.RenewalPricePeriod".localized
            .replacingOccurrences(of: "{$0}", with: renewalPrice)
            .replacingOccurrences(of: "{$1}", with: localizedRenewalSuffix(for: product, renewalPeriod: renewalPeriod))
    }
    
    private func localizedPeriod(_ period: SKProductSubscriptionPeriod) -> String {
        let units = period.numberOfUnits
        
        switch period.unit {
        case .day:
            return units == 1
                ? "PayWall.Period.Day.Singular".localized
                : "PayWall.Period.Day.Plural".localized.replacingOccurrences(of: "{$0}", with: "\(units)")
        case .week:
            return units == 1
                ? "PayWall.Period.Week.Singular".localized
                : "PayWall.Period.Week.Plural".localized.replacingOccurrences(of: "{$0}", with: "\(units)")
        case .month:
            return units == 1
                ? "PayWall.Period.Month.Singular".localized
                : "PayWall.Period.Month.Plural".localized.replacingOccurrences(of: "{$0}", with: "\(units)")
        case .year:
            return units == 1
                ? "PayWall.Period.Year.Singular".localized
                : "PayWall.Period.Year.Plural".localized.replacingOccurrences(of: "{$0}", with: "\(units)")
        @unknown default:
            return "\(units)"
        }
    }

    private func localizedSemanticPeriod(for product: SKProduct, catalog: KingOSIAPCatalog?) -> String? {
        if let offerKey = catalog?.offers.first(where: { $0.storeProductId == product.productIdentifier })?.key {
            if isOneTimePremium(product) {
                return "PayWall.Period.OneTime.2026".localized
            }
            
            switch offerKey {
            case .promotional:
                return "PayWall.Period.Promotional".localized
            case .weekly:
                return "PayWall.Period.Weekly".localized
            case .monthly:
                return "PayWall.Period.Monthly".localized
            case .bimonthly:
                return "PayWall.Period.Bimonthly".localized
            case .quarterly:
                return "PayWall.Period.Quarterly".localized
            case .semiannual:
                return "PayWall.Period.Semiannual".localized
            case .annual:
                return "PayWall.Period.Annual".localized
            }
        }

        switch product.productIdentifier {
        case InAppPurchase.Product.premiumOneTime.identifier:
            return "PayWall.Period.OneTime.2026".localized
        case InAppPurchase.Product.premiumSubscriptionPromotional.identifier:
            return "PayWall.Period.Promotional".localized
        case InAppPurchase.Product.premiumSubscriptionWeekly.identifier:
            return "PayWall.Period.Weekly".localized
        case InAppPurchase.Product.premiumSubscriptionMonthly.identifier:
            return "PayWall.Period.Monthly".localized
        case InAppPurchase.Product.premiumSubscriptionQuarterly.identifier:
            return "PayWall.Period.Quarterly".localized
        case InAppPurchase.Product.premiumSubscriptionSemiannual.identifier:
            return "PayWall.Period.Semiannual".localized
        default:
            return nil
        }
    }
    
    private func localizedRenewalSuffix(for product: SKProduct, renewalPeriod: SKProductSubscriptionPeriod) -> String {
        switch product.productIdentifier {
        case InAppPurchase.Product.premiumSubscriptionWeekly.identifier:
            return "PayWall.Intro.RenewalSlashWeek".localized
        case InAppPurchase.Product.premiumSubscriptionPromotional.identifier:
            return "PayWall.Intro.RenewalEveryPeriod".localized
                .replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
        case InAppPurchase.Product.premiumSubscriptionMonthly.identifier:
            return "PayWall.Intro.RenewalSlashMonth".localized
        case InAppPurchase.Product.premiumSubscriptionQuarterly.identifier:
            return "PayWall.Intro.RenewalEveryPeriod".localized
                .replacingOccurrences(of: "{$0}", with: "PayWall.Period.Month.Plural".localized.replacingOccurrences(of: "{$0}", with: "3").lowercased())
        case InAppPurchase.Product.premiumSubscriptionSemiannual.identifier:
            return "PayWall.Intro.RenewalEveryPeriod".localized
                .replacingOccurrences(of: "{$0}", with: "PayWall.Period.Month.Plural".localized.replacingOccurrences(of: "{$0}", with: "6").lowercased())
        default:
            switch renewalPeriod.unit {
            case .day:
                return renewalPeriod.numberOfUnits == 1
                    ? "PayWall.Intro.RenewalSlashDay".localized
                    : "PayWall.Intro.RenewalEveryPeriod".localized.replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
            case .week:
                return renewalPeriod.numberOfUnits == 1
                    ? "PayWall.Intro.RenewalSlashWeek".localized
                    : "PayWall.Intro.RenewalEveryPeriod".localized.replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
            case .month:
                return renewalPeriod.numberOfUnits == 1
                    ? "PayWall.Intro.RenewalSlashMonth".localized
                    : "PayWall.Intro.RenewalEveryPeriod".localized.replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
            case .year:
                return renewalPeriod.numberOfUnits == 1
                    ? "PayWall.Intro.RenewalSlashYear".localized
                    : "PayWall.Intro.RenewalEveryPeriod".localized.replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
            @unknown default:
                return "PayWall.Intro.RenewalEveryPeriod".localized
                    .replacingOccurrences(of: "{$0}", with: localizedPeriod(renewalPeriod).lowercased())
            }
        }
    }
    
    private func captionText(for product: SKProduct?) -> String {
        guard let product else {
            return "PayWall.Caption.Mixed".localized
        }
        
        if isOneTimePremium(product) {
            return "PayWall.Caption.OneTime.2026".localized
        }
        
        return "PayWall.Caption.CancelAnytime".localized
    }
    
    private func shouldInsertSubscriptionCaption(
        before product: SKProduct,
        at index: Int,
        products: [SKProduct],
        hasOneTimeProducts: Bool,
        hasSubscriptionProducts: Bool
    ) -> Bool {
        guard hasOneTimeProducts, hasSubscriptionProducts, index > 0 else {
            return false
        }
        
        let previousProduct = products[index - 1]
        return isOneTimePremium(previousProduct) && !isOneTimePremium(product)
    }
    
    private func shouldInsertOneTimeCaption(
        before product: SKProduct,
        at index: Int,
        products: [SKProduct],
        hasOneTimeProducts: Bool
    ) -> Bool {
        guard hasOneTimeProducts, isOneTimePremium(product) else {
            return false
        }
        
        guard index > 0 else {
            return true
        }
        
        return !isOneTimePremium(products[index - 1])
    }

    private func selectedProductIdentifier(products: [SKProduct], catalog: KingOSIAPCatalog?, abAssignment: KingOSABAssignment?) -> String? {
        if let identifierFromAB = abAssignment?.payloadString(ABPayloadKey.productHighlighted),
           products.contains(where: { $0.productIdentifier == identifierFromAB }) {
            return identifierFromAB
        }

        if let identifierFromAB = abAssignment?.payloadString(ABPayloadKey.product),
           products.contains(where: { $0.productIdentifier == identifierFromAB }) {
            return identifierFromAB
        }
        
        if let defaultIdentifier = catalog?.offers.first(where: { $0.isDefault })?.storeProductId,
           products.contains(where: { $0.productIdentifier == defaultIdentifier }) {
            return defaultIdentifier
        }

        if let oneTimeProduct = products.first(where: isOneTimePremium) {
            return oneTimeProduct.productIdentifier
        }
        
        return productWithLowestMonthlyPrice(products)?.productIdentifier
    }
    
    private func tagModel(for product: SKProduct, products: [SKProduct], catalog: KingOSIAPCatalog?, abAssignment: KingOSABAssignment?) -> TagCell.Model? {
        if let identifierFromAB = abAssignment?.payloadString(ABPayloadKey.product),
           products.contains(where: { $0.productIdentifier == identifierFromAB }),
           product.productIdentifier == identifierFromAB {
            let title = abAssignment?.payloadString(ABPayloadKey.productTag).flatMap { $0.isEmpty ? nil : $0 }
                ?? (identifierFromAB == InAppPurchase.Product.premiumSubscriptionPromotional.identifier
                    ? "PayWall.Tag.SpecialOffer".localized
                    : "PayWall.Tag.BestOffer".localized)
            return .init(
                icon: .tag,
                title: title,
                style: identifierFromAB == InAppPurchase.Product.premiumSubscriptionPromotional.identifier ? .Warning : .Success,
                align: .Left
            )
        }
        
        if isPromotional(productIdentifier: product.productIdentifier, catalog: catalog) {
            return .init(
                icon: .tag,
                title: "PayWall.Tag.SpecialOffer".localized,
                style: .Warning,
                align: .Left
            )
        }
        
        return nil
    }

    private func isPromotional(productIdentifier: String, catalog: KingOSIAPCatalog?) -> Bool {
        if isOneTimePremiumIdentifier(productIdentifier) {
            return false
        }
        
        if let offer = catalog?.offers.first(where: { $0.storeProductId == productIdentifier }) {
            return offer.key == .promotional
        }
        return productIdentifier == InAppPurchase.Product.premiumSubscriptionPromotional.identifier
    }

    private func productWithLowestMonthlyPrice(_ products: [SKProduct]) -> SKProduct? {
        products.min { lhs, rhs in
            monthlyPrice(for: lhs) < monthlyPrice(for: rhs)
        }
    }

    private func monthlyPrice(for product: SKProduct) -> Decimal {
        if isOneTimePremium(product) {
            return Decimal.greatestFiniteMagnitude
        }
        
        if let subscriptionPeriod = product.subscriptionPeriod {
            let months = monthsEquivalent(for: subscriptionPeriod)
            guard months > 0 else {
                return Decimal.greatestFiniteMagnitude
            }
            
            return product.price.decimalValue / months
        }
        return Decimal.greatestFiniteMagnitude
    }

    private func monthsEquivalent(for period: SKProductSubscriptionPeriod) -> Decimal {
        let units = Decimal(period.numberOfUnits)

        switch period.unit {
        case .day:
            return units / 30
        case .week:
            return (units * 7) / 30
        case .month:
            return units
        case .year:
            return units * 12
        @unknown default:
            return 0
        }
    }
    
    private func isAutoRenewingProduct(_ product: SKProduct) -> Bool {
        switch product.productIdentifier {
        case InAppPurchase.Product.premiumSubscriptionWeekly.identifier,
                InAppPurchase.Product.premiumSubscriptionPromotional.identifier,
                InAppPurchase.Product.premiumSubscriptionMonthly.identifier,
                InAppPurchase.Product.premiumSubscriptionQuarterly.identifier,
                InAppPurchase.Product.premiumSubscriptionSemiannual.identifier:
            return true
        default:
            return false
        }
    }
    
    private func isOneTimePremium(_ product: SKProduct) -> Bool {
        product.subscriptionPeriod == nil || isOneTimePremiumIdentifier(product.productIdentifier)
    }
    
    private func isOneTimePremiumIdentifier(_ identifier: String) -> Bool {
        let normalized = identifier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return normalized == "exchange.stickers.premium"
            || (normalized.hasSuffix(".premium") && !normalized.contains(".subscription."))
    }
}


private extension SKProductDiscount {
    var localizedPrice: String {
        price.doubleValue.moneyFormatWithCurrencySimbol(locale: priceLocale)
    }
}
