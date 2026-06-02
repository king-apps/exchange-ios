//
//  ProfileNameInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileNameBusinessLogic {
    func load(request: ProfileName.Load.Request)
    func save(request: ProfileName.Save.Request)
}


protocol ProfileNameDataStore {
    
}


class ProfileNameInteractor: ProfileNameBusinessLogic, ProfileNameDataStore {
    
    
    // Var's
    var presenter: ProfileNamePresentationLogic?
    var worker = ProfileNameWorker()
  
    
    // Handler load
    func load(request: ProfileName.Load.Request) {
        
        worker.load {
            let response = ProfileName.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: ProfileName.Save.Request) {
        
        worker.save(name: request.name) { error in
            let response = ProfileName.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
