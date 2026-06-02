//
//  ChatProductsModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ChatProducts {
  
    
    enum Load {
        struct Request {
            var height: CGFloat
        }
        struct Response {
            var height: CGFloat
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var chatProducts: [ChatProduct]?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Product {
        struct Request {
            var productId: Int
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
}
