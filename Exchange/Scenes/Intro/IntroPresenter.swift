//
//  IntroPresenter.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol IntroPresentationLogic {
    func load(response: Intro.Load.Response)
    func language(response: Intro.Language.Response)
    func remote(response: Intro.Remote.Response)
    func auth(response: Intro.Auth.Response)
    func redirect(response: Intro.Redirect.Response)
    
}


class IntroPresenter: IntroPresentationLogic {
  
    
    // Var's
    weak var viewController: IntroDisplayLogic?
  
    
    // Handler load
    func load(response: Intro.Load.Response) {
        
        let viewModel = Intro.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler language
    func language(response: Intro.Language.Response) {
        
        let viewModel = Intro.Language.ViewModel(language: response.language)
        viewController?.onLanguage(viewModel: viewModel)
        
    }
    
    
    // Handler remote
    func remote(response: Intro.Remote.Response) {
     
        let viewModel = Intro.Remote.ViewModel()
        viewController?.onRemote(viewModel: viewModel)
        
    }
    
    
    // Handler auth
    func auth(response: Intro.Auth.Response) {
        
        let viewModel = Intro.Auth.ViewModel()
        viewController?.onAuth(viewModel: viewModel)
        
    }
    
    
    // Handler redirect
    func redirect(response: Intro.Redirect.Response) {
        
        let viewModel = Intro.Redirect.ViewModel(isAuth: response.isAuth)
        viewController?.onRedirect(viewModel: viewModel)
        
    }
    
    
}
