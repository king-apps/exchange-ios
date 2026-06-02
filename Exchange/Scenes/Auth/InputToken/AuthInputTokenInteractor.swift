//
//  AuthInputTokenInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputTokenBusinessLogic {
    func load(request: AuthInputToken.Load.Request)
    func save(request: AuthInputToken.Save.Request)
}


protocol AuthInputTokenDataStore {
    var localConfig: LocalConfig? { get set }
    var email: String? { get set }
}


class AuthInputTokenInteractor: AuthInputTokenBusinessLogic, AuthInputTokenDataStore {
    
    
    // Var's
    var presenter: AuthInputTokenPresentationLogic?
    var worker = AuthInputTokenWorker()
    
    var localConfig: LocalConfig?
    var email: String?
  
    
    // Handler load
    func load(request: AuthInputToken.Load.Request) {
        
        worker.load {
            let response = AuthInputToken.Load.Response(email: self.email)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    func save(request: AuthInputToken.Save.Request) {
        
        worker.save(email: self.email, token: request.token) { error in
            let response = AuthInputToken.Save.Response(
                token: request.token,
                error: error
            )
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
