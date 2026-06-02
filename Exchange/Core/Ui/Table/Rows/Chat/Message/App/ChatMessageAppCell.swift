import UIKit


class ChatMessageAppCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelText: UILabel!
    
    
    // Model
    struct Model {
        let text: String
    }
    
    
    // Setup
    func setup(model: Model) {
        labelText.text = model.text
    }
    
    
}
