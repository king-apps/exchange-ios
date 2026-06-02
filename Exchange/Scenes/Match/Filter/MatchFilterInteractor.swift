//
//  MatchFilterInteractor.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/19/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol MatchFilterBusinessLogic {
    func load(request: MatchFilter.Load.Request)
    func fetch(request: MatchFilter.Fetch.Request)
    func save(request: MatchFilter.Save.Request)
}


protocol MatchFilterDataStore {
    
}


class MatchFilterInteractor: MatchFilterBusinessLogic, MatchFilterDataStore {
    
    
    // Var's
    var presenter: MatchFilterPresentationLogic?
    var worker = MatchFilterWorker()
  
    
    // Handler load
    func load(request: MatchFilter.Load.Request) {
        
        worker.load {
            let response = MatchFilter.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func fetch(request: MatchFilter.Fetch.Request) {
        
        worker.fetch { localConfig, remoteConfig in
            let response = MatchFilter.Fetch.Response(localConfig: localConfig, remoteConfig: remoteConfig)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: MatchFilter.Save.Request) {
        
        worker.save(radius: request.radius) {
            let response = MatchFilter.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
}
