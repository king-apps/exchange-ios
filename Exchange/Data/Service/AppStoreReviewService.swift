import Foundation


final class AppStoreReviewService {
    
    
    // Var's
    static let shared = AppStoreReviewService()
    
    
    // Const's
    private enum Key {
        static let version = "Root.AppStoreReview.Version"
        static let openCount = "Root.AppStoreReview.OpenCount"
        static let pendingVersion = "Root.AppStoreReview.PendingVersion"
        static let requestedVersion = "Root.AppStoreReview.RequestedVersion"
    }
    
    
    // Construct
    private init() {
        
    }
    
    
    // Handler app open
    func registerAppOpen() {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        let appStoreReviewOpenThreshold = RemoteConfig.shared.getStoreReviewAfterAppOpen()
        let defaults = UserDefaults.standard
        
        guard appStoreReviewOpenThreshold > 0 else {
            defaults.removeObject(forKey: Key.pendingVersion)
            return
        }
        
        if defaults.string(forKey: Key.requestedVersion) == currentVersion {
            defaults.removeObject(forKey: Key.pendingVersion)
            return
        }
        
        let storedVersion = defaults.string(forKey: Key.version)
        let currentOpenCount = storedVersion == currentVersion ? defaults.integer(forKey: Key.openCount) : 0
        let newOpenCount = currentOpenCount + 1
        
        defaults.set(currentVersion, forKey: Key.version)
        defaults.set(newOpenCount, forKey: Key.openCount)
        
        if newOpenCount >= appStoreReviewOpenThreshold {
            defaults.set(currentVersion, forKey: Key.pendingVersion)
        }
    }
    
    
    // Handler pending review request
    func consumePendingReviewRequest() -> Bool {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        let defaults = UserDefaults.standard
        
        guard defaults.string(forKey: Key.pendingVersion) == currentVersion else {
            return false
        }
        
        defaults.set(currentVersion, forKey: Key.requestedVersion)
        defaults.removeObject(forKey: Key.pendingVersion)
        return true
    }
    
    
}
