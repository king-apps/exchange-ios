import Foundation
import UIKit


class TextBodySmallCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelText: UILabel!
    
    
    // Models
    struct Model {
        var text: String
        var align: NSTextAlignment?
    }
    
    
    // Setup
    func setup(model: TextBodySmallCell.Model) {
        
        labelText.text = model.text
        labelText.textAlignment = model.align ?? .center
        
    }
    
    
}
