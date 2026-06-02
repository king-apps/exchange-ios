//
//  AuthWelcomeInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 11/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthWelcomeBusinessLogic {
    func load(request: AuthWelcome.Load.Request)
    func email(request: AuthWelcome.Email.Request)
    func skip(request: AuthWelcome.Skip.Request)
}


protocol AuthWelcomeDataStore {
    
}


class AuthWelcomeInteractor: AuthWelcomeBusinessLogic, AuthWelcomeDataStore {
    
    
    // Var's
    var presenter: AuthWelcomePresentationLogic?
    var worker = AuthWelcomeWorker()
  
    
    // Handler load
    func load(request: AuthWelcome.Load.Request) {
        
        worker.load {
            let response = AuthWelcome.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler email
    func email(request: AuthWelcome.Email.Request) {
        
        worker.email {
            let response = AuthWelcome.Email.Response()
            self.presenter?.email(response: response)
        }
    }
    
    
    // Handler skip
    func skip(request: AuthWelcome.Skip.Request) {
        
        worker.skip { error in
            let response = AuthWelcome.Skip.Response(error: error)
            self.presenter?.skip(response: response)
        }
    }
    
    
}
