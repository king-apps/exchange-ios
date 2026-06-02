import UIKit


extension InputTokenCell: UITextFieldTokenBaseDelegate {
    
    func uiTokenTextFieldDidBackward(_ textfield: UITextFieldTokenBase) {
        let t = textfield.text ?? ""
        if t.isEmpty {
            moveToPreviousField(from: textfield)
        }
        else {
            textfield.text = ""
        }
        delegateToken()
    }
    
}
