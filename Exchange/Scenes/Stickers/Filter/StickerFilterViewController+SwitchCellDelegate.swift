import UIKit


extension StickerFilterViewController: SwitchCellDelegate {
    
    func switchCellDidChange(_ cell: SwitchCell, identifier: SwitchCell.Identifier, isOn: Bool) {
        
        let _ = rows.setSwitchValue(isOn, identifier: identifier)
        
        // Regra dos switchs
        switch identifier {
        case .collected:
            if isOn {
                setSwitchValue(identifier: .duplicated, isOn: false)
                setSwitchValue(identifier: .missing, isOn: false)
                setSwitchValue(identifier: .published, isOn: false)
            }
        case .duplicated:
            if isOn {
                setSwitchValue(identifier: .collected, isOn: false)
                setSwitchValue(identifier: .missing, isOn: false)
                setSwitchValue(identifier: .published, isOn: false)
            }
        case .missing:
            if isOn {
                setSwitchValue(identifier: .collected, isOn: false)
                setSwitchValue(identifier: .duplicated, isOn: false)
                setSwitchValue(identifier: .published, isOn: false)
            }
        case .published:
            if isOn {
                setSwitchValue(identifier: .collected, isOn: false)
                setSwitchValue(identifier: .duplicated, isOn: false)
                setSwitchValue(identifier: .missing, isOn: false)
            }
        default:
            break
        }
        
        save()
        
    }
    
    
    private func setSwitchValue(identifier: SwitchCell.Identifier, isOn: Bool) {
        if let row = rows.setSwitchValue(isOn, identifier: identifier) {
            if let cell = tableView?.cellForRow(at: IndexPath(row: row, section: 0)) as? SwitchCell {
                DispatchQueue.main.async {
                    cell.isOnSwitch.setOn(isOn, animated: true)
                }
            }
        }
    }
    
}
