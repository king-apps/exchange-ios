import UIKit

extension SuperLikeViewController: InputTextViewCellDelegate {
    
    func inputTextViewCellEditingBegin(text: String, tag: Int) {
        handerButtonSend()
    }
    func inputTextViewCellEditingChanged(text: String, tag: Int) {
        rows.setInputTextViewValue(text, identifier: .SuperLike)
        handerButtonSend()
        
    }
}
