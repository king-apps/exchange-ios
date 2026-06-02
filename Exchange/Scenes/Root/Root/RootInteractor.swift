//
//  RootInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol RootBusinessLogic {
    func load(request: Root.Load.Request)
    func controllers(request: Root.Controllers.Request)
}


protocol RootDataStore {
    
}


class RootInteractor: RootBusinessLogic, RootDataStore {
    
    
    // Var's
    var presenter: RootPresentationLogic?
    var worker = RootWorker()
  
    
    // Handler load
    func load(request: Root.Load.Request) {
        
        worker.load { user in
            let response = Root.Load.Response(user: user)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Controllers
    func controllers(request: Root.Controllers.Request) {
        
        worker.controllers { list in
            let response = Root.Controllers.Response(list: list)
            self.presenter?.controllers(response: response)
        }
        
    }
   
    
}
