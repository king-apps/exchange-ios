//
//  NewProductCategoryListWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class NewProductCategoryListWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler search
    func search(completion: @escaping(_ categories: [ProductCategory]?, _ error: String?) -> ()) {
        /*
        let api = ProductApi()
        api.listCategories { list, error in
            completion(list, error)
        }
        */
    }
    
    
    // Handler save
    func save(row: Int, categories: [ProductCategory]?, completion: @escaping(_ product: Product?, _ error: String?) -> ()) {
        
        if let categories {
            let product = Product()
            let category = categories[row]
            product.category = category
            completion(product, nil)
        }
        else {
            completion(nil, "Error")
        }
        
    }
    
    
    
}
