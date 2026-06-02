//
//  AuthNotificationViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthNotificationDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthNotification.Load.ViewModel)
    func onNotification(viewModel: AuthNotification.Notification.ViewModel)
    func onSave(viewModel: AuthNotification.Save.ViewModel)
}


class AuthNotificationViewController: AuthMainBaseViewController, AuthNotificationDisplayLogic {
  
    
    // Var's
    var interactor: AuthNotificationBusinessLogic?
    var router: (NSObjectProtocol & AuthNotificationRoutingLogic & AuthNotificationDataPassing)?

  
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
        AppAnalytics.shared.log(.authNotificationViewed)
    }
    
    
    // Handler load
    func load() {
        let request = AuthNotification.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthNotification.Load.ViewModel) {
        
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
        if let nav = parent?.parent as? AuthMainViewController, nav.pageControl.currentPage == 0 {
            nav.navigationController?.popViewController(animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // Handler notification
    func notification() {
        let request = AuthNotification.Notification.Request()
        interactor?.notification(request: request)
    }
    func onNotification(viewModel: AuthNotification.Notification.ViewModel) {
        save(granted: viewModel.granted)
    }
    
    
    // Handler save
    func save(granted: Bool) {
        let request = AuthNotification.Save.Request(granted: granted)
        interactor?.save(request: request)
    }
    func onSave(viewModel: AuthNotification.Save.ViewModel) {
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
        notification()
    }
    
    
}
