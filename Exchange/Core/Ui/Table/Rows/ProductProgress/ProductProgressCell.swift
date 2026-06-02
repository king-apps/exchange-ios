import UIKit
import Kingfisher


class ProductProgressCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIconLeft: UIImageView!
    @IBOutlet var imageViewProduct: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var imageViewIconRight: UIImageView!
    
    
    
    // Model
    struct Model {
        let id: Int
        let iconLeft: AppTheme.Icon
        let image: String?
        let title: String
        var progress: Float
        var description: String
        var iconRight: AppTheme.Icon
        var color: AppTheme.ColorToken
        var identifier: Identifier
    }
    
    enum Identifier {
        case boostProfile
        case boostProduct
        case collected
        case duplicated
    }
    
    
    // Setup
    func setup(model: Model) {
        
        // Icon Left
        imageViewProduct.layer.cornerRadius = AppTheme.Radius.lg
        imageViewProduct.backgroundColor = AppTheme.Colors.backgroundBase
        if let image = model.image, let url = URL(string: image) {
            imageViewIconLeft.kf.setImage(with: url)
            imageViewIconLeft.contentMode = .scaleAspectFill
        }
        else {
            imageViewIconLeft.contentMode = .center
            imageViewIconLeft.image = AppTheme.icon(model.iconLeft)
            imageViewIconLeft.tintColor = AppTheme.color(model.color)
        }
        
        // Text
        labelTitle.text = model.title
        labelDescription.text = model.description
        
        // Progress
        progressView.progress = model.progress
        progressView.progressTintColor = AppTheme.color(model.color)
        progressView.trackTintColor = AppTheme.Colors.neutral100
        
        // Icon right
        if model.iconRight == .none {
            imageViewIconRight.isHidden = true
            imageViewIconRight.removeFromSuperview()
        } else {
            imageViewIconRight.image = AppTheme.icon(model.iconRight)
        }
        
        
    }
    
    
}
