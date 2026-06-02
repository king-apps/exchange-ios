import UIKit
import Foundation


class SpacingCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var constraintHeight: NSLayoutConstraint!
    
    
    // Model
    struct Model {
        var size: AppTheme.Spacing
    }
    
    
    // Setup
    func setup(model: SpacingCell.Model) {
        constraintHeight.constant = model.size.rawValue
    }
    
    
}
