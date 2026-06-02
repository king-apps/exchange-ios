import Foundation
import UIKit


class TextBodyCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelText: UILabel!
    
    
    // Models
    struct Model {
        var text: String
        var align: NSTextAlignment?
        var color: AppTheme.ColorToken?
    }
    
    
    // Setup
    func setup(model: Model) {
        
        labelText.text = model.text
        labelText.textAlignment = model.align ?? .center
        
        if let color = model.color {
            labelText.textColor = AppTheme.color(color)
        }
        
    }
    
    
}
