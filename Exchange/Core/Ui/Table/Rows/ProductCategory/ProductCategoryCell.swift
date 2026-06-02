import UIKit
import Kingfisher


protocol ProductCategorySelectCellDelegate {
    func productCategorySelectCellDidTap(id: Int)
}


class ProductCategoryCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var viewThemeLeft: UIViewBaseWidget!
    @IBOutlet var imageViewLeft: UIImageView!
    @IBOutlet var imageViewGradientLeft: UIImageView!
    @IBOutlet var labelThemeLeft: UILabel!
    
    @IBOutlet var viewThemeRight: UIViewBaseWidget!
    @IBOutlet var imageViewRight: UIImageView!
    @IBOutlet var imageViewGradientRight: UIImageView!
    @IBOutlet var labelThemeRight: UILabel!
    
    var delegate: ProductCategorySelectCellDelegate?
    
    
    // Model
    struct Model {
        var productCategoryLeft: ProductCategory
        var productCategoryRight: ProductCategory?
    }
    
    
    // Setup
    func setup(model: Model) {
        
        // Left
        let leftColor = model.productCategoryLeft.getPrimaryColor()
        viewThemeLeft.backgroundColor = leftColor
        viewThemeLeft.tag = model.productCategoryLeft.getId()
        
       // imageViewLeft.kf.setImage(with: URL(string: model.productCategoryLeft.getCoverUrl()))
        imageViewGradientLeft.tintColor = leftColor
        labelThemeLeft.text = model.productCategoryLeft.getName()
        labelThemeLeft.textColor = .white
        viewThemeLeft.onTap = {
            self.delegate?.productCategorySelectCellDidTap(id: self.viewThemeLeft.tag)
        }
        
        // Right
        if let productCategoryRight = model.productCategoryRight {
            viewThemeRight.isHidden = false
            let rightColor = productCategoryRight.getPrimaryColor()
            viewThemeRight.backgroundColor = rightColor
            viewThemeRight.tag = productCategoryRight.getId()
            //imageViewRight.kf.setImage(with: URL(string: productCategoryRight.getCoverUrl()))
            imageViewGradientRight.tintColor = rightColor
            labelThemeRight.text = productCategoryRight.getName()
            labelThemeRight.textColor = .white
            viewThemeRight.onTap = {
                self.delegate?.productCategorySelectCellDidTap(id: self.viewThemeRight.tag)
            }
        }
        else {
            viewThemeRight.isHidden = true
        }
        
    }
    
    
}
