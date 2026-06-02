import UIKit

extension InputTextViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.endEditing(true)
            return false
        }
        else {
            
            handlerMask()
            return true
        }

    }
    
    func textViewDidChange(_ textView: UITextView) {
        handlerMaxLength()
        delegate?.inputTextViewCellEditingChanged(text: textView.text!, tag: textView.tag)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewEnter()
        delegate?.inputTextViewCellEditingBegin(text: textView.text!, tag: textView.tag)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        setTextViewMessagePlaceholder()
    }
    
    
}
