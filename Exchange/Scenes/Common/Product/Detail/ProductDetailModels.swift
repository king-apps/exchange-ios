//
//  ProductDetailModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ProductDetail {
  
    
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
            var product: Product?
        }
        struct ViewModel {
            var images: [String]
            var name: String
            var distance: String
            var category: String
            var categoryImage: String
            var conservation: String
            var description: String
        }
    }
    
}
