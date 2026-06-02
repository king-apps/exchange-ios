import UIKit
import Foundation


class UITableViewCellBase: UITableViewCell {
    
    
    // Var's
    @IBOutlet var effectView: UIView?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        updateDynamicColors()
    }
    
    func updateDynamicColors() {
        
    }
    
    
    // Did Highlight
    func didHighlight() {
        
        if let effectView = effectView {
            
            if effectView.alpha == 0.0 {
                let rect = effectView.frame
                effectView.frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: 0, height: rect.size.height)
                UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut, animations: {
                    effectView.alpha = 1.0
                    effectView.frame = rect
                }) { (finished) in
                    
                }
            }
            else {
                UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut, animations: {
                    effectView.alpha = 0.0
                }) { (finished) in
                    
                }
            }
            
        }
        
    }
    
    
    // Did Unhighlight
    func didUnhighlight() {
        
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: AppConfig.Animation.duration * 3, options: .curveEaseInOut, animations: {
            self.effectView?.alpha = 0.0
        }, completion: nil)
        
    }
    
    
}
