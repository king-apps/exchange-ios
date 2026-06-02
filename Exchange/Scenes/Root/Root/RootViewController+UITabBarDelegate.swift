import UIKit

extension RootViewController {
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setNeedsStatusBarAppearanceUpdate()
        AppHaptics.selection()
    }
    
}
