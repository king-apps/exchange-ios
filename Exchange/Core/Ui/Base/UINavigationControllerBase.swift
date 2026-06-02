import UIKit
import Foundation


final class UINavigationControllerBase: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            // Force a layout update without animation during the transition
            UIView.performWithoutAnimation {
                self?.view.layoutIfNeeded()
            }
        }, completion: nil)
    }
    
}
