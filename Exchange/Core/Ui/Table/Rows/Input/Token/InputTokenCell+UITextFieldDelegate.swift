import UIKit


extension InputTokenCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Backspace
        if string.isEmpty {
            if textField.text?.isEmpty ?? true {
                moveToPreviousField(from: textField)
            }
            else {
                textField.text = ""
            }
            return false
        }
        
        // Apenas numeros
        guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        
        //
        if let text = textField.text, !text.isEmpty {
            textField.text = string
            moveToNextField(from: textField)
            return false
        }
        
        return true
    }
    
}
