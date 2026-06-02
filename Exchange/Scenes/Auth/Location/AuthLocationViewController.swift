//
//  AuthLocationViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthLocationDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthLocation.Load.ViewModel)
    func onLocation(viewModel: AuthLocation.Location.ViewModel)
    func onSave(viewModel: AuthLocation.Save.ViewModel)
}


class AuthLocationViewController: MainBaseViewController, AuthLocationDisplayLogic {
  
    
    // Var's
    var interactor: AuthLocationBusinessLogic?
    var router: (NSObjectProtocol & AuthLocationRoutingLogic & AuthLocationDataPassing)?

  
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
        
    }
    
    
    // Handler load
    func load() {
        let request = AuthLocation.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthLocation.Load.ViewModel) {
        
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.showProgress()
            nav.handlerProgress()
        }
    }
    
    
    // Handler location
    func location() {
        let request = AuthLocation.Location.Request()
        interactor?.location(request: request)
    }
    func onLocation(viewModel: AuthLocation.Location.ViewModel) {
        save()
    }
    
    
    // Handler save
    func save() {
        let request = AuthLocation.Save.Request()
        interactor?.save(request: request)
    }
    func onSave(viewModel: AuthLocation.Save.ViewModel) {
        performSegue(withIdentifier: "Next", sender: nil)
    }
    
    
    // Handler back
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // Handler actions
    @IBAction func didBack() {
        AppHaptics.tap()
        back()
    }
    @IBAction func didSave() {
        AppHaptics.tap()
        location()
    }
    
    
}
