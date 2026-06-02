import UIKit


extension ProfileNameViewController: InputTextCellDelegate {

    func inputTextCellEditingBegin(text: String, tag: Int) {
        tableView?.isScrollEnabled = false
    }
    func inputTextCellEditingChanged(text: String, tag: Int) {
        rows.setInputTextValue(text, identifier: .Name)
        handlerButtonSave()
    }
}
