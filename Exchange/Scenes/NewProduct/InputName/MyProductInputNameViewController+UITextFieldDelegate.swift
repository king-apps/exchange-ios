import UIKit
import Foundation


extension MyProductInputNameViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.didSave()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        /*
        if (textField.text!.count + string.count) > kProductInputNameMaxCharacterLength {
            return false
        }
        */
        return true
    }
    
    @objc
    func textFieldDidEditingChanged(_ textField: UITextField) {
        handlerCharacterLength()
        handlerButtonSave()
    }
    
    
}
