import UIKit


class TextCaptionSemiboldCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    
    
    // Model
    struct Model {
        var color: AppTheme.ColorToken
        var icon: AppTheme.Icon
        var title: String
    }
    
    
    // Construct
    func setup(model: Model) {
    
        let color = AppTheme.color(model.color)
        imageViewIcon.tintColor = color
        labelTitle.textColor = color
        
        if model.icon == .none {
            imageViewIcon.isHidden = true
            imageViewIcon.removeFromSuperview()
        }
        else {
            imageViewIcon.isHidden = false
            imageViewIcon.image = AppTheme.icon(model.icon)
        }
        
        labelTitle.text = model.title
    }
    
    
}
