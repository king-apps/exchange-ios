//
//  AuthInputTokenModels.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum AuthInputToken {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var email: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
            var description: String
        }
    }

    
    enum Save {
        struct Request {
            var token: String
        }
        struct Response {
            var token: String
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
}
