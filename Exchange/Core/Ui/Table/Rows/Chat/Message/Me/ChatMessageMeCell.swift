import UIKit


class ChatMessageMeCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelText: UILabel!
    @IBOutlet var labelDate: UILabel!
    
    
    // Model
    struct Model {
        let text: String
        let date: String
    }
    
    
    // Setup
    func setup(model: Model) {
        labelText.text = model.text
        labelDate.text = model.date
    }
    
}
