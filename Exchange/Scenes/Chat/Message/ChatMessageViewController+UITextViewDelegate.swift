import UIKit
import Foundation


extension ChatMessageViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        send()
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        handlerButtonSend()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewMessageEnter()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        setTextViewMessagePlaceholder()
    }
    
}
