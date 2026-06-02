//
//  InputTextCell+ UITextFieldDelegate.swift
//  Kimba
//
//  Created by Douglas Cicarello on 24/10/24.
//
import UIKit

extension InputTextCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}
