//
//  WebContentViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import WebKit


protocol WebContentDisplayLogic: AnyObject {
    func onLoad(viewModel: WebContent.Load.ViewModel)
    func onFetch(viewModel: WebContent.Fetch.ViewModel)
    func onFetch(error: String)
}


class WebContentViewController: MainBaseViewController, WebContentDisplayLogic {
  
    
    // Var's
    var interactor: WebContentBusinessLogic?
    var router: (NSObjectProtocol & WebContentRoutingLogic & WebContentDataPassing)?

    @IBOutlet var webView: WKWebView!
    @IBOutlet var viewLoading: UIView!
    
  
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
        webView.navigationDelegate = self
        webView.alpha = 0
        webView.scrollView.showsVerticalScrollIndicator = false
        viewLoading.alpha = 1.0
        viewLoading.layer.cornerRadius = AppTheme.Radius.lg
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = WebContent.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: WebContent.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = WebContent.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: WebContent.Fetch.ViewModel) {
        let request = URLRequest(url: viewModel.url)
        webView.load(request)
    }
    func onFetch(error: String) {
        hideLoading()
        displayAlert(
            title: "Alert.Title.Warning".localized,
            message: error
        )
    }
    
    
    // Handler loading
    func hideLoading() {
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0) {
            self.webView.alpha = 1.0
            self.viewLoading.alpha = 0.0
        } completion: { finished in
            
        }
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    
    
}
