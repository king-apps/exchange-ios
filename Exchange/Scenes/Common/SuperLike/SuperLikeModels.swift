//
//  SuperLikeModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 20/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum SuperLike {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var price: String?
        }
        struct ViewModel {
            var title: String
            var isEnabled: Bool
        }
    }
    
    
    enum Send {
        struct Request {
            var message: String
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
}
