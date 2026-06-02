import UIKit
import Foundation


class UIButtonBase: UIButton {
    
    
    // Var's
    var isLoading = false
    var bufferText: String?
    var bufferIsEnabled: Bool?
    var bufferColor: UIColor?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                    self.alpha = 0.9
                }) { (finished) in
                }
            }
            else {
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                    self.alpha = 1.0
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }) { (finished) in
                }
            }
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let text = self.title(for: .normal), !text.isEmpty {
            self.setTitle(text.localized, for: .normal)
        }
        self.layer.cornerRadius = AppTheme.Radius.lg
    }
    
    
    // Handler loading
    func showLoading(text:String = "App.Loading".localized) {
        
        if !isLoading {
            isLoading = true
            
            // Save the actual text and state on button
            bufferText      = title(for: .disabled)
            bufferIsEnabled = self.isEnabled
            isEnabled       = false
            
            setTitle(text, for: .disabled)
        }
       
    }
    func hideLoading() {
        
        if let bufferText = bufferText {
            setTitle(bufferText, for: .disabled)
        }
        if let bufferIsEnabled = bufferIsEnabled {
            isEnabled = bufferIsEnabled
        }
    
        isLoading = false
    }
    
    
}
