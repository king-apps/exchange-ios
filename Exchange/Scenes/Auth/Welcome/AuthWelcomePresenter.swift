//
//  AuthWelcomePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 11/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthWelcomePresentationLogic {
    func load(response: AuthWelcome.Load.Response)
    func email(response: AuthWelcome.Email.Response)
    func skip(response: AuthWelcome.Skip.Response)
}


class AuthWelcomePresenter: AuthWelcomePresentationLogic {
  
    
    // Var's
    weak var viewController: AuthWelcomeDisplayLogic?
  
    
    // Handler load
    func load(response: AuthWelcome.Load.Response) {
        
        let viewModel = AuthWelcome.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler email
    func email(response: AuthWelcome.Email.Response) {
        
        let viewModel = AuthWelcome.Email.ViewModel()
        viewController?.onEmail(viewModel: viewModel)
        
    }
    
    
    // Handler skip
    func skip(response: AuthWelcome.Skip.Response) {
        
        if let error = response.error {
            viewController?.onSkip(error: error)
        }
        else {
            let viewModel = AuthWelcome.Skip.ViewModel()
            viewController?.onSkip(viewModel: viewModel)
        }
        
    }
    
    
}
