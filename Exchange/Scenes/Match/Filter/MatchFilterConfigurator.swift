//
//  MatchFilterConfigurator.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/19/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


extension MatchFilterViewController {
  
    
    // Setup
    func setup() {
   
        let viewController          = self
        let interactor              = MatchFilterInteractor()
        let presenter               = MatchFilterPresenter()
        let router                  = MatchFilterRouter()
    
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
