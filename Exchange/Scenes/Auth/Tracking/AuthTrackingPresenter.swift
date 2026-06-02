//
//  AuthTrackingPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthTrackingPresentationLogic {
    func load(response: AuthTracking.Load.Response)
    func tracking(response: AuthTracking.Tracking.Response)
    func save(response: AuthTracking.Save.Response)
}


class AuthTrackingPresenter: AuthTrackingPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthTrackingDisplayLogic?
  
    
    // Handler load
    func load(response: AuthTracking.Load.Response) {
        
        let viewModel = AuthTracking.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler tracking
    func tracking(response: AuthTracking.Tracking.Response) {
        
        let viewModel = AuthTracking.Tracking.ViewModel(granted: response.granted)
        viewController?.onTracking(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthTracking.Save.Response) {
        
        let viewModel = AuthTracking.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
