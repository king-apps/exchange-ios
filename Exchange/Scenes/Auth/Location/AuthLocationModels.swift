//
//  AuthLocationModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum AuthLocation {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Location {
        struct Request {
            
        }
        struct Response {
            var granted: Bool
        }
        struct ViewModel {
            var granted: Bool
        }
    }

    
    enum Save {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
}
