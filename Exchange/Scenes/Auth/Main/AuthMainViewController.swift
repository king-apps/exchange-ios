//
//  AuthMainViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 26/11/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthMainDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthMain.Load.ViewModel)
    func onPageControl(viewModel: AuthMain.PageControl.ViewModel)
}


class AuthMainViewController: AuthMainBaseViewController, AuthMainDisplayLogic {
  
    
    // Var's
    var interactor: AuthMainBusinessLogic?
    var router: (NSObjectProtocol & AuthMainRoutingLogic & AuthMainDataPassing)?
    
    @IBOutlet var pageControl: UIPageControl!

  
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
        let request = AuthMain.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthMain.Load.ViewModel) {
        setupPageControl()
    }
    
    
    // Handler page control
    func setupPageControl() {
        let request = AuthMain.PageControl.Request()
        interactor?.pageControl(request: request)
    }
    func onPageControl(viewModel: AuthMain.PageControl.ViewModel) {
        pageControl.numberOfPages = viewModel.pages
    }
    
    
    // Handler progress
    func handlerProgress() {
        
        if let nav = self.children.first as? UINavigationController {
            let currentPage = nav.children.count - 1
            pageControl.currentPage = currentPage
        }
        
    }
    func showProgress() {
        self.pageControl.isHidden = false
    }
    func hideProgress() {
        self.pageControl.isHidden = true
    }
    
    
}
