import Foundation
import UIKit


class TextCaptionCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelText: UILabel!
    
    
    // Models
    struct Model {
        var icon: AppTheme.Icon?
        var text: String
        var align: NSTextAlignment?
        var color: UIColor?
    }
    
    
    // Setup
    func setup(model: TextCaptionCell.Model) {
        
        labelText.text = model.text
        labelText.textAlignment = model.align ?? .center
       //  labelText.textColor = model.color ?? AppTheme.Colors.onSurfaceSecondary
        imageViewIcon.tintColor = model.color ?? .secondaryLabel
        
        if let icon = model.icon {
            imageViewIcon.image = AppTheme.icon(icon)
        }
        else {
            imageViewIcon.removeFromSuperview()
        }
    }
    
    
}
