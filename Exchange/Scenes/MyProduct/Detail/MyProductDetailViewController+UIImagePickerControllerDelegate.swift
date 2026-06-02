//
//  MyProductDetailViewController+UIImagePickerControllerDelegate.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/9/21.
//

import UIKit
import Foundation


extension MyProductDetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            setImageForCurrentPage(image: image)
        }
        else {
            setImageForCurrentPage(image: nil)
        }
    }
    

}
