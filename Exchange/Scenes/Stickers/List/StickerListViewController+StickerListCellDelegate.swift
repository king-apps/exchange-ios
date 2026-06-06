import UIKit

extension StickerListViewController: StickerListCellDelegate {
    
    func stickerListCellOpenCamera(id: Int) {
        selectedStickerIdForProduct = id
        router?.routeToStickerImage()
    }
    func stickerListCellOpenProduct(id: Int) {
        product(id: id)
    }
    func stickerListCellDidTapSticker(id: Int) {
        guard LocalConfig.shared.getStickerFilterLocked() == false else {
            AppHaptics.warning()
            router?.routeToStickerLocked()
            return
        }
        
        updateCollected(id: id, operation: .add)
    }
    
    func stickerListCellDidLongPressSticker(id: Int) {
        guard LocalConfig.shared.getStickerFilterLocked() == false else {
            AppHaptics.warning()
            router?.routeToStickerLocked()
            return
        }
        
        updateCollected(id: id, operation: .remove)
    }
    
    func handlerImage() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let didLibrary = UIAlertAction(title: "App.Library".localized, style: .default) { _ in
            self.openLibary()
        }
        alert.addAction(didLibrary)
        
        let didCamera = UIAlertAction(title: "App.Camera".localized, style: .default) { _ in
            self.openCamera()
        }
        alert.addAction(didCamera)
        
        let didClose = UIAlertAction(title: "App.Close".localized, style: .cancel)
        alert.addAction(didClose)
        
        present(alert, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = false
            vc.delegate = self
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
        }
        else {
            displayAlert(nil, message: "App.Camera.Unavailable".localized)
        }
    }
    func openLibary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.mediaTypes = ["public.image"]
        vc.allowsEditing = false
        vc.delegate = self
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
}
