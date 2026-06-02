import Foundation


enum AppEnvironment {
    
    
    enum StoreProduct {
        case superLike
        case boostProfile
        
        fileprivate var infoKey: String {
            switch self {
            case .superLike:
                return "STORE_PRODUCT_SUPERLIKE"
            case .boostProfile:
                return "STORE_PRODUCT_BOOST_PROFILE"
            }
        }
    }
    
    
    private static func info(_ key: String, required: Bool = true) -> String {
        guard let value = optionalInfo(key), value.isEmpty == false else {
            guard required else {
                return ""
            }
            fatalError("Missing or empty Info.plist key: \(key)")
        }
        return value
    }
    
    private static func optionalInfo(_ key: String) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            return nil
        }
        
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? nil : trimmedValue
    }

    static var apiBaseUrl: URL {
        URL(string: info("EX_API_BASE_URL"))!
    }

    static var appId: String {
        info("EX_APP_ID")
    }

    static var appKey: String {
        info("EX_APP_KEY")
    }
    
    static var language: String {
        info("EX_LANGUAGE")
    }
    
    // ADS
    // General
    static var adAppId: String { info("GADApplicationIdentifier", required: false) }
    static var adAppOpen: String { info("AD_APP_OPEN", required: false) }
    static var adReward: String { info("AD_REWARD", required: false) }
    static var adBanner: String { info("AD_BANNER", required: false) }
    
    // STORE
    static func storeProductIdentifier(for product: StoreProduct) -> String {
        info(product.infoKey)
    }
    
}
