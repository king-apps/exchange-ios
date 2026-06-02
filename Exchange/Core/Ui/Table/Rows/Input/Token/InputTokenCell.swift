import UIKit


protocol InputTokenCellDelegate {
    func inputTokenCellDidUpdate(token: String)
}


class InputTokenCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var textField1: UITextFieldTokenBase!
    @IBOutlet var textField2: UITextFieldTokenBase!
    @IBOutlet var textField3: UITextFieldTokenBase!
    @IBOutlet var textField4: UITextFieldTokenBase!
    private var textFields: [UITextField] = []
    private var style: Style = .default
    var delegate: InputTokenCellDelegate?
    
    
    // Models
    struct Model {
        var token: String
        var style: InputTokenCell.Style
    }
    enum Style {
        case `default`
        case error
    }
    
    
    // Setup
    func setup(model: InputTokenCell.Model) {
        
        textFields = [
            textField1,
            textField2,
            textField3,
            textField4
        ]
        handlerStyle(style: model.style)
        handlePaste(model.token, from: textField1)
    }
    
    
    // Style
    func handlerStyle(style: InputTokenCell.Style) {
        self.style = style
        
        for textField in textFields {
            if style == .default {
                applyStyleDefault(textField: textField)
            }
            else if style == .error {
                applyStyleError(textField: textField)
            }
        }
    }
    private func applyStyleDefault(textField: UITextField) {
        
        textField.backgroundColor = AppTheme.Colors.backgroundSurface100
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        textField.layer.cornerRadius = AppTheme.Radius.sm
        textField.font = UIFont.systemFont(ofSize: AppTheme.FontSize.headingLg, weight: .bold)
        
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        if let t = textField as? UITextFieldTokenBase {
            t.tokenBaseDelegate = self
        }
        
    }
    private func applyStyleError(textField: UITextField) {
        
        textField.backgroundColor = AppTheme.Colors.backgroundSurface100
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = AppTheme.Colors.error500.resolvedColor(with: traitCollection).cgColor
        textField.layer.cornerRadius = AppTheme.Radius.sm
        textField.font = UIFont.systemFont(ofSize: AppTheme.FontSize.headingLg, weight: .bold)
        
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        if let t = textField as? UITextFieldTokenBase {
            t.tokenBaseDelegate = self
        }
    }
    
    override func updateDynamicColors() {
        super.updateDynamicColors()
        handlerStyle(style: style)
    }
    
    
    @objc
    func textDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            
            if text.count > 1 {
                handlePaste(text, from: textField)
            }
            if text.count == 1 {
                moveToNextField(from: textField)
            }
            
        }
        
        delegateToken()
    }
    
    
    // Handler paste
    private func handlePaste(_ pastedText: String, from textField: UITextField) {
        
        // Opcional: limpar todos os campos a partir do startIndex
        for i in 0..<textFields.count {
            textFields[i].text = ""
        }
        
        // Mantém apenas dígitos
        let digits = pastedText.filter { $0.isNumber }
        guard !digits.isEmpty else {
            textField.text = ""
            return
        }

        // Descobre em qual posição do array o usuário colou
        guard let startIndex = textFields.firstIndex(of: textField) else { return }


        // Distribui os dígitos nos fields
        var fieldIndex = startIndex
        for digit in digits {
            if fieldIndex >= textFields.count { break }
            textFields[fieldIndex].text = String(digit)
            fieldIndex += 1
        }

        // Foco: se ainda tem campo vazio, foca nele; se não, fecha o teclado
        if fieldIndex < textFields.count {
            textFields[fieldIndex].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
    }
    
    
    // Handler delegate
    func delegateToken() {
        let token = getToken()
        delegate?.inputTokenCellDidUpdate(token: token)
    }
    
    
    // Get Token
    func getToken() -> String {
        let token = textFields.compactMap({$0.text}).joined()
        return token
    }
    
    
    // Handler next and previous
    func moveToNextField(from textField: UITextField) {
        
        if let index = textFields.firstIndex(of: textField) {
            let nextIndex = index + 1
            if nextIndex < textFields.count {
                textFields[nextIndex].becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
        }
        
    }
    func moveToPreviousField(from textField: UITextField) {
        
        if let index = textFields.firstIndex(of: textField) {
            let prevIndex = index - 1
            if prevIndex >= 0 {
                textFields[prevIndex].becomeFirstResponder()
                textFields[prevIndex].text = ""
            }
        }
        
    }

    
}
