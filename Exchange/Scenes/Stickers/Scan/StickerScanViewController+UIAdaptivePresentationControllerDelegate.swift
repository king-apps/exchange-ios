import UIKit


extension StickerScanViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didDismissResult()
    }
    
}


extension StickerScanViewController: StickerScanResultViewControllerDelegate {
    
}
