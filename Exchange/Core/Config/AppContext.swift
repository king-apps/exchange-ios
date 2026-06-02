import UIKit
import StoreKit


enum AppContext {
    static var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error: AppDelegate")
        }
        return delegate
    }
}


enum AppPreviewMode {
    
    #if DEBUG
    // Enable temporarily to capture App Store screenshots with a cleaner premium UI.
    static let isEnabled = false
    #else
    static let isEnabled = false
    #endif
    
    static let forcePremium = isEnabled
    static let hideAds = isEnabled
    
}
