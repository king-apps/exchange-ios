//
//  IntroConfigurator.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


extension IntroViewController {
  
    
    // Setup
    func setup() {
   
        let viewController          = self
        let interactor              = IntroInteractor()
        let presenter               = IntroPresenter()
        let router                  = IntroRouter()
    
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
