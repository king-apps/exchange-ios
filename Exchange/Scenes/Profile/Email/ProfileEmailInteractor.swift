//
//  ProfileEmailInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailBusinessLogic {
    func load(request: ProfileEmail.Load.Request)
    func save(request: ProfileEmail.Save.Request)
}


protocol ProfileEmailDataStore {
    var email: String? { get }
}


class ProfileEmailInteractor: ProfileEmailBusinessLogic, ProfileEmailDataStore {
    
    
    // Var's
    var presenter: ProfileEmailPresentationLogic?
    var worker = ProfileEmailWorker()
    
    var email: String?
  
    
    // Handler load
    func load(request: ProfileEmail.Load.Request) {
        
        worker.load {
            let response = ProfileEmail.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: ProfileEmail.Save.Request) {
        
        worker.save(email: request.email) { error in
            
            // Store in memory
            self.email = request.email
            
            let response = ProfileEmail.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
