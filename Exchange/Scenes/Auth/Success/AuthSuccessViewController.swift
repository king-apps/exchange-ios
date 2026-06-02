//
//  AuthSuccessViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 02/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthSuccessDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthSuccess.Load.ViewModel)
    func onSave(viewModel: AuthSuccess.Save.ViewModel)
}


class AuthSuccessViewController: AuthMainBaseViewController, AuthSuccessDisplayLogic {
  
    
    // Var's
    var interactor: AuthSuccessBusinessLogic?
    var router: (NSObjectProtocol & AuthSuccessRoutingLogic & AuthSuccessDataPassing)?

  
    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlerProgress()
    }
    
    
    // Setup inputs
    func setupInputs() {
        
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        AppAnalytics.shared.log(.authSuccessViewed)
    }
    
    
    // Handler load
    func load() {
        let request = AuthSuccess.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthSuccess.Load.ViewModel) {
        
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.hideProgress()
            nav.handlerProgress()
        }
    }
    
    
    // save
    func save() {
        let request = AuthSuccess.Save.Request()
        interactor?.save(request: request)
    }
    func onSave(viewModel: AuthSuccess.Save.ViewModel) {
        router?.routeToRoot()
    }
    
    
    // Actions
    @IBAction func didSave() {
        save()
    }
    
    
}
