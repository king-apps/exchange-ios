//
//  MyProductInputNameModels.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 2/23/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum MyProductInputName {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            var code: String
            var color: UIColor?
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
