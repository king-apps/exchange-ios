import UIKit


extension StickerListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        selectedStickerIdForProduct = nil
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            guard let id = selectedStickerIdForProduct else {
                displayAlert(nil, message: "Alert.Generic.Error".localized)
                return
            }
            
            selectedStickerIdForProduct = nil
            createProduct(id: id, image: image)
        }
    }
}
