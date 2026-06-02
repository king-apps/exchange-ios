//
//  ProfileNameModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ProfileName {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var user: User?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }

    
    enum Save {
        struct Request {
            var name: String
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
}
