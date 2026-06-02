//
//  IntroViewController.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol IntroDisplayLogic: AnyObject {
    func onLoad(viewModel: Intro.Load.ViewModel)
    func onLanguage(viewModel: Intro.Language.ViewModel)
    func onRemote(viewModel: Intro.Remote.ViewModel)
    func onAuth(viewModel: Intro.Auth.ViewModel)
    func onRedirect(viewModel: Intro.Redirect.ViewModel)
}


class IntroViewController: MainBaseViewController, IntroDisplayLogic {
  
    
    // Var's
    var interactor: IntroBusinessLogic?
    var router: (NSObjectProtocol & IntroRoutingLogic & IntroDataPassing)?

  
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
        let request = Intro.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: Intro.Load.ViewModel) {
        language()
    }
    
    
    // Handler language
    func language() {
        let request = Intro.Language.Request()
        interactor?.language(request: request)
    }
    func onLanguage(viewModel: Intro.Language.ViewModel) {
        print("Language: \(viewModel.language)")
        remote()
    }
    
    
    // Handler remote
    func remote() {
        let request = Intro.Remote.Request()
        interactor?.remote(request: request)
    }
    func onRemote(viewModel: Intro.Remote.ViewModel) {
        auth()
    }
    
    
    // Handler auth
    func auth() {
        let request = Intro.Auth.Request()
        interactor?.auth(request: request)
    }
    func onAuth(viewModel: Intro.Auth.ViewModel) {
        redirect()
    }
    
    
    // Handler redirect
    func redirect() {
        let request = Intro.Redirect.Request()
        interactor?.redirect(request: request)
    }
    func onRedirect(viewModel: Intro.Redirect.ViewModel) {
        if viewModel.isAuth {
            router?.routeToRoot()
        }
        else {
            router?.routeToAuth()
        }
    }
    
    

}
