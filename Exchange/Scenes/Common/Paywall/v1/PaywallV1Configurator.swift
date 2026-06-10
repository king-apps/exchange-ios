//
//  PaywallV1Configurator.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


extension PaywallV1ViewController {
  
    
    // Setup
    func setup() {
   
        let viewController          = self
        let interactor              = PaywallV1Interactor()
        let presenter               = PaywallV1Presenter()
        let router                  = PaywallV1Router()
    
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
