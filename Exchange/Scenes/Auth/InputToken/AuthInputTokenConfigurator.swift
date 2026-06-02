//
//  AuthInputTokenConfigurator.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


extension AuthInputTokenViewController {
  
    
    // Setup
    func setup() {
   
        let viewController          = self
        let interactor              = AuthInputTokenInteractor()
        let presenter               = AuthInputTokenPresenter()
        let router                  = AuthInputTokenRouter()
    
        viewController.interactor   = interactor
        viewController.router       = router
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        router.viewController       = viewController
        router.dataStore            = interactor
    }
  
    
    // Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    
}
