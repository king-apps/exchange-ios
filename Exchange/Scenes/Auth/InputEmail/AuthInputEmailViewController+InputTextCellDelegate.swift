import UIKit


extension AuthInputEmailViewController: InputTextCellDelegate {
    
    
    func inputTextCellEditingBegin(text: String, tag: Int) {
        tableView?.isScrollEnabled = false
    }
    func inputTextCellEditingChanged(text: String, tag: Int) {
        
        rows.setInputTextValue(text, identifier: .Email)
        handlerButtonSave()
        
    }
    

}
