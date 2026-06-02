//
//  ProfileEmailTokenModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ProfileEmailToken {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var email: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }

    
    enum Save {
        struct Request {
            var token: String
        }
        struct Response {
            var email: String?
            var token: String
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
}
