import UIKit
import Foundation


class MainBaseTabBarController: UITabBarController {
    
    
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }

    private func setupTabBarAppearance() {
      
        view.backgroundColor = AppTheme.Colors.backgroundSurface100

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.Colors.backgroundSurface100

        appearance.shadowColor = .clear

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

    }
    
    
}
