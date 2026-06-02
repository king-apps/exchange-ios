import UIKit
import Kingfisher


class MyProductCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var imageViewProduct: UIImageView!
    @IBOutlet var labelProductName: UILabel!
    
    
    // Model
    struct Model {
        var image: String?
        var name: String
        var color: UIColor
    }
    
    
    // Load
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        
        // Container
        viewContainer.layer.borderWidth = 1.0
        viewContainer.layer.cornerRadius = AppTheme.Radius.lg
        viewContainer.clipsToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // Setup
    func setup(model: Model) {
        if let image = model.image {
            imageViewProduct.kf.setImage(with: URL(string: image))
        }
        viewContainer.backgroundColor = model.color
        updateDynamicColors()
        effectView?.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        effectView?.alpha = 0.0
        
        labelProductName.text = model.name
        
    }
    
    override func updateDynamicColors() {
        super.updateDynamicColors()
        viewContainer?.layer.borderColor = UIColor.secondarySystemBackground.resolvedColor(with: traitCollection).cgColor
    }
    
    
}
