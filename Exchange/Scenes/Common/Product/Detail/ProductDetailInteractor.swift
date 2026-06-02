//
//  ProductDetailInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProductDetailBusinessLogic {
    func load(request: ProductDetail.Load.Request)
    func fetch(request: ProductDetail.Fetch.Request)
}


protocol ProductDetailDataStore {
    var product: Product? { get set }
}


class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore {
    
    
    // Var's
    var presenter: ProductDetailPresentationLogic?
    var worker = ProductDetailWorker()
    
    var product: Product?
  
    
    // Handler load
    func load(request: ProductDetail.Load.Request) {
        
        worker.load {
            let response = ProductDetail.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: ProductDetail.Fetch.Request) {
        
        let response = ProductDetail.Fetch.Response(product: self.product)
        presenter?.fetch(response: response)
        
    }
    
    
}
