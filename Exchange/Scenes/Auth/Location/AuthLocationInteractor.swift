//
//  AuthLocationInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthLocationBusinessLogic {
    func load(request: AuthLocation.Load.Request)
    func location(request: AuthLocation.Location.Request)
    func save(request: AuthLocation.Save.Request)
}


protocol AuthLocationDataStore {
    
}


class AuthLocationInteractor: AuthLocationBusinessLogic, AuthLocationDataStore {
    
    
    // Var's
    var presenter: AuthLocationPresentationLogic?
    var worker = AuthLocationWorker()
  
    
    // Handler load
    func load(request: AuthLocation.Load.Request) {
        
        worker.load {
            let response = AuthLocation.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler location
    func location(request: AuthLocation.Location.Request) {
        
        worker.location { granted in
            let response = AuthLocation.Location.Response(granted: granted)
            self.presenter?.location(response: response)
        }
    }
    
    
    // Handler save
    func save(request: AuthLocation.Save.Request) {
        
        worker.save {
            let response = AuthLocation.Save.Response()
            self.presenter?.save(response: response)
        }
    }
    
    
}
