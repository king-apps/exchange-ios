//
//  AuthWelcomeViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 11/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthWelcomeDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthWelcome.Load.ViewModel)
    func onEmail(viewModel: AuthWelcome.Email.ViewModel)
    func onSkip(viewModel: AuthWelcome.Skip.ViewModel)
    func onSkip(error: String)
}


class AuthWelcomeViewController: AuthMainBaseViewController, AuthWelcomeDisplayLogic {
  
    
    // Var's
    var interactor: AuthWelcomeBusinessLogic?
    var router: (NSObjectProtocol & AuthWelcomeRoutingLogic & AuthWelcomeDataPassing)?
    
    @IBOutlet var buttonSkip: UIButtonOutline!

  
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
    }
    
    
    // Setup inputs
    func setupInputs() {
        
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = AuthWelcome.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthWelcome.Load.ViewModel) {
        
    }
    
    
    // Handler email
    func email() {
        let request = AuthWelcome.Email.Request()
        interactor?.email(request: request)
    }
    func onEmail(viewModel: AuthWelcome.Email.ViewModel) {
        performSegue(withIdentifier: "Email", sender: nil)
    }
    
    
    // Handler skip
    func skip() {
        buttonSkip.showLoading()
        let request = AuthWelcome.Skip.Request()
        interactor?.skip(request: request)
    }
    func onSkip(viewModel: AuthWelcome.Skip.ViewModel) {
        buttonSkip.hideLoading()
        performSegue(withIdentifier: "Skip", sender: nil)
    }
    func onSkip(error: String) {
        buttonSkip.hideLoading()
        displayAlert(
            nil,
            message: error
        )
    }
    
    
    // Handler Actions
    @IBAction func didEmail() {
        email()
    }
    @IBAction func didSkip() {
        skip()
    }
    
    
}
