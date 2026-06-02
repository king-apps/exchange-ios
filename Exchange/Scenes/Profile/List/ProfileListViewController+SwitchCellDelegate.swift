import UIKit


extension ProfileListViewController: SwitchCellDelegate {
    
    func switchCellDidChange(_ cell: SwitchCell, identifier: SwitchCell.Identifier, isOn: Bool) {
        
        let _ = rows.setSwitchValue(isOn, identifier: identifier)
        save()
        
    }
    
}
