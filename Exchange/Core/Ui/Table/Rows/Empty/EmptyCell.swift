import UIKit
import Foundation


class EmptyCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelText: UILabel!
    
    
    // Model
    struct Model {
        var icon: AppTheme.Icon
        var text: String
        var height: CGFloat?
    }
    
    
    // Setup
    func setup(model: EmptyCell.Model) {
                
        imageViewIcon.image = AppTheme.icon(model.icon)
        labelText.text = model.text
        
    }
    
}
