//
//  AuthInputEmailInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputEmailBusinessLogic {
    func load(request: AuthInputEmail.Load.Request)
    func save(request: AuthInputEmail.Save.Request)
}


protocol AuthInputEmailDataStore {
    var name: String? { get set }
    var email: String? { get }
}


class AuthInputEmailInteractor: AuthInputEmailBusinessLogic, AuthInputEmailDataStore {
    
    
    // Var's
    var presenter: AuthInputEmailPresentationLogic?
    var worker = AuthInputEmailWorker()
    
    var name: String?
    var email: String?
  
    
    // Handler load
    func load(request: AuthInputEmail.Load.Request) {
        
        worker.load {
            let response = AuthInputEmail.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: AuthInputEmail.Save.Request) {
        
        worker.save(name: self.name, email: request.email) { error in
            
            // Store in memory
            self.email = request.email
            
            let success = error == nil
            let response = AuthInputEmail.Save.Response(success: success)
            self.presenter?.save(response: response)
        }
        
    }

    
    
}
