//
//  AuthInputNameInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 13/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputNameBusinessLogic {
    func load(request: AuthInputName.Load.Request)
    func save(request: AuthInputName.Save.Request)
}


protocol AuthInputNameDataStore {
    var name: String? { get }
}


class AuthInputNameInteractor: AuthInputNameBusinessLogic, AuthInputNameDataStore {
    
    
    // Var's
    var presenter: AuthInputNamePresentationLogic?
    var worker = AuthInputNameWorker()
  
    var name: String?
    
    
    // Handler load
    func load(request: AuthInputName.Load.Request) {
        
        worker.load {
            let response = AuthInputName.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: AuthInputName.Save.Request) {
        
        worker.save(name: request.name) {
            
            // Store in memory
            self.name = request.name
            
            let response = AuthInputName.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
