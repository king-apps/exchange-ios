//
//  AuthTrackingViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthTrackingDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthTracking.Load.ViewModel)
    func onTracking(viewModel: AuthTracking.Tracking.ViewModel)
    func onSave(viewModel: AuthTracking.Save.ViewModel)
}


class AuthTrackingViewController: MainBaseViewController, AuthTrackingDisplayLogic {
  
    
    // Var's
    var interactor: AuthTrackingBusinessLogic?
    var router: (NSObjectProtocol & AuthTrackingRoutingLogic & AuthTrackingDataPassing)?

  
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
        AppAnalytics.shared.log(.authTrackingViewed)
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = AuthTracking.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthTracking.Load.ViewModel) {
        
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.showProgress()
            nav.handlerProgress()
        }
    }
    
    
    // Handler back
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // Handler tracking
    func tracking() {
        let request = AuthTracking.Tracking.Request()
        interactor?.tracking(request: request)
    }
    func onTracking(viewModel: AuthTracking.Tracking.ViewModel) {
        save(granted: viewModel.granted)
    }
    
    
    // Handler save
    func save(granted: Bool) {
        let request = AuthTracking.Save.Request(granted: granted)
        interactor?.save(request: request)
    }
    func onSave(viewModel: AuthTracking.Save.ViewModel) {
        AppHaptics.success()
        performSegue(withIdentifier: "Next", sender: nil)
    }

    
    // Handler actions
    @IBAction func didBack() {
        AppHaptics.tap()
        back()
    }
    @IBAction func didSave() {
        AppHaptics.tap()
        tracking()
    }
    
    
}
