import Foundation
import UIKit


class AuthMainBaseViewController: MainBaseViewController {
    
    
    // Var's
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch traitCollection.userInterfaceStyle {
        case .dark:
            return .lightContent
        default:
            return .darkContent
        }
    }
    
    
    // Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    // Trait
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    
}
