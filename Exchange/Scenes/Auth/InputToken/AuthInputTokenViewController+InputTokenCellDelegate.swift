import UIKit


extension AuthInputTokenViewController: InputTokenCellDelegate {
    
    func inputTokenCellDidUpdate(token: String) {
        rows.setInputTokenValue(token)
        handlerButtonSave()
        setInputTokenStyleDefaultIfNeeded()
    }
    
    private func setInputTokenStyleDefaultIfNeeded() {
        if let model = rows.inputTokenModel(), model.style == .error {
            self.load()
        }
    }
    
}
