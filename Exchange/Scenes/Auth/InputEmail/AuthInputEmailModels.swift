//
//  AuthInputEmailModels.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum AuthInputEmail {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var email: String
        }
        struct Response {
            var success: Bool
        }
        struct ViewModel {
    
        }
    }
    
    
}
