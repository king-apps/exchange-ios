import UIKit
import Kingfisher


class ProductCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewProduct: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageViewIcon: UIImageView!
    
    
    // Model
    struct Model {
        let id: Int
        let image: String
        let name: String
        var icon: AppTheme.Icon
    }
    
    
    // Setup
    func setup(model: Model) {
        
        imageViewProduct.layer.cornerRadius = AppTheme.Radius.lg
        imageViewProduct.layer.borderWidth = 1
        updateDynamicColors()
        imageViewProduct.kf.setImage(with: URL(string: model.image))
        
        if model.icon == .none {
            imageViewIcon.isHidden = true
            imageViewIcon.removeFromSuperview()
        } else {
            imageViewIcon.image = AppTheme.icon(model.icon)
        }
        
        labelName.text = model.name
        
    }
    
    override func updateDynamicColors() {
        super.updateDynamicColors()
        imageViewProduct?.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
    }
    
}
