//
//  AuthLocationConfigurator.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


extension AuthLocationViewController {
  
    
    // Setup
    func setup() {
   
        let viewController          = self
        let interactor              = AuthLocationInteractor()
        let presenter               = AuthLocationPresenter()
        let router                  = AuthLocationRouter()
    
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
