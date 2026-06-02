//
//  AuthTrackingInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthTrackingBusinessLogic {
    func load(request: AuthTracking.Load.Request)
    func tracking(request: AuthTracking.Tracking.Request)
    func save(request: AuthTracking.Save.Request)
}


protocol AuthTrackingDataStore {
    var localConfig: LocalConfig? { get set }
}


class AuthTrackingInteractor: AuthTrackingBusinessLogic, AuthTrackingDataStore {
    
    
    // Var's
    var presenter: AuthTrackingPresentationLogic?
    var worker = AuthTrackingWorker()
    
    var localConfig: LocalConfig?
  
    
    // Handler load
    func load(request: AuthTracking.Load.Request) {
        
        worker.load {
            let response = AuthTracking.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler tracking
    func tracking(request: AuthTracking.Tracking.Request) {
    
        worker.tracking { granted in
            let response = AuthTracking.Tracking.Response(granted: granted)
            self.presenter?.tracking(response: response)
        }
    }
    
    
    // Handler save
    func save(request: AuthTracking.Save.Request) {
        
        worker.save(granted: request.granted) {
            let response = AuthTracking.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
    
}
