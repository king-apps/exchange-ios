//
//  NewProductCategoryListModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum NewProductCategoryList {
  
    
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

    
    enum Search {
        struct Request {
            
        }
        struct Response {
            var categories: [ProductCategory]?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var row: Int
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
}
