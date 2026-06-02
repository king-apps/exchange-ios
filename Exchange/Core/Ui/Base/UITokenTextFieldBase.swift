import UIKit


protocol UITextFieldTokenBaseDelegate: AnyObject {
    func uiTokenTextFieldDidBackward(_ textfield: UITextFieldTokenBase)
}

class UITextFieldTokenBase: UITextField {
    
    
    // Var's
    var tokenBaseDelegate: UITextFieldTokenBaseDelegate?
    
    
    override func deleteBackward() {
        tokenBaseDelegate?.uiTokenTextFieldDidBackward(self)
    }
    
    
}
