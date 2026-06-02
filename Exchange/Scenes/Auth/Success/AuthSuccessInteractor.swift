//
//  AuthSuccessInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 02/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthSuccessBusinessLogic {
    func load(request: AuthSuccess.Load.Request)
    func save(request: AuthSuccess.Save.Request)
}


protocol AuthSuccessDataStore {
    var localConfig: LocalConfig? { get set }
}


class AuthSuccessInteractor: AuthSuccessBusinessLogic, AuthSuccessDataStore {
    
    
    // Var's
    var presenter: AuthSuccessPresentationLogic?
    var worker = AuthSuccessWorker()
    
    var localConfig: LocalConfig?
  
    
    // Handler load
    func load(request: AuthSuccess.Load.Request) {
        
        worker.load {
            let response = AuthSuccess.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: AuthSuccess.Save.Request) {
        
        worker.save {
            let response = AuthSuccess.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
    
}
