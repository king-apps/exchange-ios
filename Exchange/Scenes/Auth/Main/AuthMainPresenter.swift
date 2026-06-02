//
//  AuthMainPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 26/11/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthMainPresentationLogic {
    func load(response: AuthMain.Load.Response)
    func pageControl(response: AuthMain.PageControl.Response)
}


class AuthMainPresenter: AuthMainPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthMainDisplayLogic?
  
    
    // Handler load
    func load(response: AuthMain.Load.Response) {
        
        let viewModel = AuthMain.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler page control
    func pageControl(response: AuthMain.PageControl.Response) {
        
        let pages: Int = response.auth.isAuth() ? 4 : 6
        
        let viewModel = AuthMain.PageControl.ViewModel(pages: pages)
        viewController?.onPageControl(viewModel: viewModel)
        
    }
    
    
}
