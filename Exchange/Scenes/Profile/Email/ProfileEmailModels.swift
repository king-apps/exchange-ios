//
//  ProfileEmailModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ProfileEmail {
  
    
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
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
}
