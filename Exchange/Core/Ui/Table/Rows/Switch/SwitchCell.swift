import UIKit


protocol SwitchCellDelegate: AnyObject {
    func switchCellDidChange(_ cell: SwitchCell, identifier: SwitchCell.Identifier, isOn: Bool)
}


class SwitchCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var isOnSwitch: UISwitch!
    var delegate: SwitchCellDelegate?
    
    
    // Enum
    enum Identifier: Int {
        case match = 0
        case message = 1
        case superLike = 2
        case collected
        case missing
        case duplicated
        case published
    }
    
    
    // Model
    struct Model {
        let title: String
        var isOn: Bool
        let identifier: Identifier
    }
    
    
    // Setup
    func setup(model: Model) {
        labelTitle.text = model.title
        isOnSwitch.isOn = model.isOn
        isOnSwitch.tag = model.identifier.rawValue
    }
    
    
    // Handler actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if let delegate, let switchTag = SwitchCell.Identifier(rawValue: sender.tag) {
            delegate.switchCellDidChange(self, identifier: switchTag, isOn: sender.isOn)
        }
    }
    
}
