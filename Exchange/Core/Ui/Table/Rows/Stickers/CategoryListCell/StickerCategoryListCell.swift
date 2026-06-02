import UIKit


class StickerCategoryListCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIconLeft: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageViewIconRight: UIImageView!
    

    // Model
    struct Model {
        var iconLeft: String
        var name: String
        var iconRight: AppTheme.Icon
    }
    
    
    // Setup
    func setup(model: Model) {
        
        imageViewIconLeft.layer.cornerRadius = imageViewIconLeft.bounds.width / 2
        imageViewIconLeft.clipsToBounds = true
        
        if let image = UIImage(named: model.iconLeft) {
            imageViewIconLeft.image = image
        }
        
        labelName.text = model.name.uppercased()
        
        if model.iconRight == .none {
            imageViewIconRight.removeFromSuperview()
        }
        else {
            imageViewIconRight.image = AppTheme.icon(model.iconRight)
        }
        
        
    }
    
    
}
