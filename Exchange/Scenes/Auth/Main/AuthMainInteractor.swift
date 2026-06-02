//
//  AuthMainInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 26/11/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthMainBusinessLogic {
    func load(request: AuthMain.Load.Request)
    func pageControl(request: AuthMain.PageControl.Request)
}


protocol AuthMainDataStore {
    
}


class AuthMainInteractor: AuthMainBusinessLogic, AuthMainDataStore {
    
    
    // Var's
    var presenter: AuthMainPresentationLogic?
    var worker = AuthMainWorker()
  
    
    // Handler load
    func load(request: AuthMain.Load.Request) {
        
        worker.load {
            let response = AuthMain.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler page control
    func pageControl(request: AuthMain.PageControl.Request) {
        
        worker.pageControl { auth in
            let response = AuthMain.PageControl.Response(auth: auth)
            self.presenter?.pageControl(response: response)
        }
        
    }
    
    
}
