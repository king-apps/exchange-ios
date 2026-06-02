//
//  NewProductCategoryListInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductCategoryListBusinessLogic {
    func load(request: NewProductCategoryList.Load.Request)
    func search(request: NewProductCategoryList.Search.Request)
    func save(request: NewProductCategoryList.Save.Request)
}


protocol NewProductCategoryListDataStore {
    var product: Product? { get }
}


class NewProductCategoryListInteractor: NewProductCategoryListBusinessLogic, NewProductCategoryListDataStore {
    
    
    // Var's
    var presenter: NewProductCategoryListPresentationLogic?
    var worker = NewProductCategoryListWorker()
    
    var product: Product?
    var categories: [ProductCategory]?
  
    
    // Handler load
    func load(request: NewProductCategoryList.Load.Request) {
        
        worker.load {
            let response = NewProductCategoryList.Load.Response(height: request.height)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler search
    func search(request: NewProductCategoryList.Search.Request) {
        
        worker.search { categories, error in
            
            // Store in memory
            self.categories = categories
            
            let response = NewProductCategoryList.Search.Response(categories: categories)
            self.presenter?.search(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: NewProductCategoryList.Save.Request) {
        
        worker.save(row: request.row, categories: self.categories) { product, error in
            
            // Store in memory
            self.product = product
            
            let response = NewProductCategoryList.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
