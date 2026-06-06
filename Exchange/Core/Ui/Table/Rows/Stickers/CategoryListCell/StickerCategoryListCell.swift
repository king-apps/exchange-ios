import UIKit


class StickerCategoryListCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIconLeft: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelCount: UILabel!
    @IBOutlet var viewCount: UIView!
    

    // Model
    struct Model {
        var iconLeft: String
        var name: String
        var count: String
        var color: UIColor
    }
    
    
    // Setup
    func setup(model: Model) {
        
        imageViewIconLeft.layer.cornerRadius = imageViewIconLeft.bounds.width / 2
        imageViewIconLeft.clipsToBounds = true
        
        if let image = UIImage(named: model.iconLeft) {
            imageViewIconLeft.image = image
        }
        
        labelName.text = model.name.uppercased()
        labelCount.text = model.count
        viewCount.backgroundColor = model.color
        viewCount.layer.cornerRadius = AppTheme.Radius.lg
        
        
    }
    
    
}
