//
//  AuthSuccessPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 02/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthSuccessPresentationLogic {
    func load(response: AuthSuccess.Load.Response)
    func save(response: AuthSuccess.Save.Response)
}


class AuthSuccessPresenter: AuthSuccessPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthSuccessDisplayLogic?
  
    
    // Handler load
    func load(response: AuthSuccess.Load.Response) {
        
        let viewModel = AuthSuccess.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthSuccess.Save.Response) {
        
        let viewModel = AuthSuccess.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
