//
//  AuthLocationPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthLocationPresentationLogic {
    func load(response: AuthLocation.Load.Response)
    func location(response: AuthLocation.Location.Response)
    func save(response: AuthLocation.Save.Response)
}


class AuthLocationPresenter: AuthLocationPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthLocationDisplayLogic?
  
    
    // Handler load
    func load(response: AuthLocation.Load.Response) {
        
        let viewModel = AuthLocation.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler location
    func location(response: AuthLocation.Location.Response) {
        
        let viewModel = AuthLocation.Location.ViewModel(granted: response.granted)
        viewController?.onLocation(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthLocation.Save.Response) {
        
        let viewModel = AuthLocation.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
