import UIKit


class UILabelBase: UILabel {
    
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let text = self.text {
            self.text = text.localized
        }
    }
    
    
}
