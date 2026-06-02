//
//  MyProductDetailModels.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/8/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum MyProductDetail {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            var name: String
            var category: String
            var categoryUrl: String?
            var conservation: String
            var description: String
            var images: [String]
        }
    }
    
    
    enum Save {
        struct Request {
            var images: [UIImage?]
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
    enum Remove {
        struct Request {
            
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
}
