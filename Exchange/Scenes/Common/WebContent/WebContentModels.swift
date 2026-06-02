//
//  WebContentModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum WebContent {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var url: URL?
            var error: String?
        }
        struct ViewModel {
            var url: URL
        }
    }
    
    
}
