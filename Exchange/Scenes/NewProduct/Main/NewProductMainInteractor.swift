//
//  NewProductMainInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductMainBusinessLogic {
    func load(request: NewProductMain.Load.Request)
    func save(request: NewProductMain.Save.Request)
}


protocol NewProductMainDataStore {
    var product: Product? { get }
}


class NewProductMainInteractor: NewProductMainBusinessLogic, NewProductMainDataStore {
    
    
    // Var's
    var presenter: NewProductMainPresentationLogic?
    var worker = NewProductMainWorker()
    
    var product: Product?
  
    
    // Handler load
    func load(request: NewProductMain.Load.Request) {
        
        worker.load {
            let response = NewProductMain.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: NewProductMain.Save.Request) {
        
        worker.save {
            
            // Store in memory
            self.product = request.product
            
            let response = NewProductMain.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
