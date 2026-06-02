import Foundation
import UIKit


protocol InputTextViewCellDelegate {
    func inputTextViewCellEditingChanged(text: String, tag: Int)
    func inputTextViewCellEditingBegin(text: String, tag: Int)
}


class InputTextViewCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var labelError: UILabel!
    @IBOutlet var labelCount: UILabel!
    
    var type: InputTextType = .Default
    var delegate: InputTextViewCellDelegate?
    var maxLength: Int = 0
    var placeholder: String = ""
    
    
    // Models
    struct Model {
        var title: String
        var placeholder: String
        var value: String
        var error: String
        var type: InputTextType
        var identifier: InputTextViewCell.Identifier
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
        case SuperLike
    }

    
    // Setup
    func setup(model: InputTextViewCell.Model, tag: Int) {
    
        labelTitle.text = model.title
        textView.text = model.value
        textView.tag = tag
        textView.delegate = self
        type = model.type
        maxLength = model.maxLength
        
        setupKeyboardForType()
        handlerMaxLength()
        styleDefault()
        if !model.error.isEmpty {
            showError(text: model.error, animated: false)
        }
       
        placeholder = model.placeholder
        setTextViewMessagePlaceholder()
    }
    
    
    // Placeholder
    func setTextViewMessagePlaceholder() {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = AppTheme.Colors.textOnSurfaceDisabled
        }
    }
    func setTextViewEnter() {
        if textView.text == placeholder {
            textView.text = ""
        }
        textView.textColor = AppTheme.Colors.textOnSurface
    }
    
    
    // Handler styles
    private func styleDefault() {
        labelError.alpha = 0.0
    }
    
    
    // Handler mask
    func handlerMask() {
        if let text = self.textView.text, text.count > 0 {
            if text.count > maxLength { self.textView.text = String( Array(text).prefix(maxLength - 1) ) }
            //if type == .Cnpj { self.textField.text = text.mask(kMaskCnpj) }
        }
    }
    
    
    // Handler max length
    func handlerMaxLength() {
        let length = textView.text?.count ?? 0
        labelCount.text = "\(length)/\(maxLength)"
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
    
    // Handler keyboard
    private func setupKeyboardForType() {
        
        if type == .Name {
            textView.keyboardType = .namePhonePad
            textView.autocapitalizationType = .words
            textView.autocorrectionType = .default
        }
        if type == .Default {
            textView.keyboardType = .default
            textView.autocapitalizationType = .words
            textView.autocorrectionType = .default
        }
        if type == .Number {
            textView.keyboardType = .numberPad
        }
        if type == .Email {
            textView.keyboardType = .emailAddress
            textView.autocapitalizationType = .none
            textView.autocorrectionType = .no
        }
        
    }
    
    
}



extension InputTextViewCell.Model {
    
    func getError() -> String? {
    
        if isRequired {
            
            // Check if is empty
            if value.isEmpty {
                return "Input.Error.Empty".localized
            }
    
        }
        
        return nil
    }
    
}
