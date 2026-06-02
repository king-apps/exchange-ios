import Foundation


enum ApiEnvironment {
    
    
    // Var's
    static var baseUrl: URL { AppEnvironment.apiBaseUrl }
    static var appId: String { AppEnvironment.appId }
    
    
    // Headers
    static var defaultHeaders: [String: String] {
        [
            "platform": "ios",
            "app-id": String(appId),
            "lang": LocalConfig.shared.getLanguage(),
            "version": appVersion(),
            "is-premium": String(InAppPurchase.shared.isPremium())
        ]
    }
    
    
}

func appVersion() -> String {
    let shortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    let buildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    return shortVersion ?? buildVersion ?? "0"
}
