import Foundation
import UIKit


protocol InputTextCellDelegate {
    func inputTextCellEditingChanged(text: String, tag: Int)
    func inputTextCellEditingBegin(text: String, tag: Int)
}


class InputTextCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var labelError: UILabel!
    @IBOutlet var labelCount: UILabel!
    
    var type: InputTextType = .Default
    var delegate: InputTextCellDelegate?
    var maxLength: Int = 0
    
    
    // Models
    struct Model {
        var title: String
        var placeholder: String
        var value: String
        var error: String
        var type: InputTextType
        var identifier: InputTextCell.Identifier
        var isRequired: Bool
        var maxLength: Int
        var args: Any?
    }


    enum InputTextType {
        case Default
        case Name
        case Number
        case Email
    }


    enum Identifier {
        case Name
        case Email
        case SuperLike
    }

    
    // Setup
    func setup(model: InputTextCell.Model, tag: Int) {
    
        labelTitle.text = model.title
        textField.text = model.value
        textField.placeholder = model.placeholder
        textField.tag = tag
        textField.delegate = self
        type = model.type
        maxLength = model.maxLength
        
        setupKeyboardForType()
        handlerMask()
        handlerMaxLength()
        styleDefault()
        if !model.error.isEmpty {
            showError(text: model.error, animated: false)
        }
    
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingBegin), for: .editingDidBegin)
    }
    
    
    // Handler styles
    private func styleDefault() {
        labelError.alpha = 0.0
    }
    
    
    // Handler changed
    @objc
    func editingChanged() {
        
        handlerMask()
        handlerMaxLength()
        hideError(animated: true)
        
        delegate?.inputTextCellEditingChanged(
            text: self.textField.text ?? "",
            tag: self.textField.tag
        )
        
    }
    @objc
    func editingBegin() {
        
        delegate?.inputTextCellEditingBegin(
            text: self.textField.text ?? "",
            tag: self.textField.tag
        )
        
    }
    
    
    // Handler error
    private func showError(text: String, animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
                self.labelError.text = text
                self.labelError.alpha = 1.0
            } completion: { finished in
                
            }
        }
        else {
            self.labelError.text = text
            self.labelError.alpha = 1.0
        }
        
    }
    private func hideError(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
                self.labelError.alpha = 0
            } completion: { finished in
                
            }
        }
        else {
            self.labelError.alpha = 1.0
        }
        
    }
    
    
    // Handler mask
    private func handlerMask() {
        if let text = self.textField.text, text.count > 0 {
            if text.count > maxLength { self.textField.text = String( Array(text).prefix(maxLength) ) }
            //if type == .Cnpj { self.textField.text = text.mask(kMaskCnpj) }
        }
    }
    
    
    // Handler max length
    private func handlerMaxLength() {        
        let length = textField.text?.count ?? 0
        labelCount.text = "\(length)/\(maxLength)"
    }
    
    
    // Handler keyboard
    private func setupKeyboardForType() {
        
        if type == .Name {
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
            textField.autocorrectionType = .default
        }
        if type == .Default {
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
            textField.autocorrectionType = .default
        }
        if type == .Number {
            textField.keyboardType = .numberPad
        }
        if type == .Email {
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
        }
        
    }
    
    
}



extension InputTextCell.Model {
    
    func getError() -> String? {
    
        if isRequired {
            
            // Check if is empty
            if value.isEmpty {
                return "Input.Error.Empty".localized
            }
            
            if identifier == .Email {
                if !value.isValidEmail() {
                    return "Input.Email.Error.Invalid".localized
                }
            }
            
            if identifier == .Name {
                if value.isEmpty || value.count < 3 {
                    return "Input.Name.Error.Invalid".localized
                }
            }
        }
        
        return nil
    }
    
}
