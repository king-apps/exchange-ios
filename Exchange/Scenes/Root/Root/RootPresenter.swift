//
//  RootPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol RootPresentationLogic {
    func load(response: Root.Load.Response)
    func controllers(response: Root.Controllers.Response)
}


class RootPresenter: RootPresentationLogic {
  
    
    // Var's
    weak var viewController: RootDisplayLogic?
  
    
    // Handler load
    func load(response: Root.Load.Response) {
        
        let messagesNotViewed = response.user.getMessagesNotViewed()
        let viewModel = Root.Load.ViewModel(messagesNotViewed: messagesNotViewed)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler controllers
    func controllers(response: Root.Controllers.Response) {
        
        let viewModel = Root.Controllers.ViewModel(list: response.list)
        viewController?.onControllers(viewModel: viewModel)
        
    }
    
    
}
