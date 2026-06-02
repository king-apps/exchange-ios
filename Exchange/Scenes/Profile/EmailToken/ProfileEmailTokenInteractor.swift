//
//  ProfileEmailTokenInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailTokenBusinessLogic {
    func load(request: ProfileEmailToken.Load.Request)
    func save(request: ProfileEmailToken.Save.Request)
}


protocol ProfileEmailTokenDataStore {
    var email: String? { get set }
}


class ProfileEmailTokenInteractor: ProfileEmailTokenBusinessLogic, ProfileEmailTokenDataStore {
    
    
    // Var's
    var presenter: ProfileEmailTokenPresentationLogic?
    var worker = ProfileEmailTokenWorker()
  
    var email: String?
    
    
    // Handler load
    func load(request: ProfileEmailToken.Load.Request) {
        
        worker.load {
            let response = ProfileEmailToken.Load.Response(email: self.email)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: ProfileEmailToken.Save.Request) {
        
        worker.save(email: self.email, token: request.token) { error in
            let response = ProfileEmailToken.Save.Response(
                email: self.email,
                token: request.token,
                error: error
            )
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
