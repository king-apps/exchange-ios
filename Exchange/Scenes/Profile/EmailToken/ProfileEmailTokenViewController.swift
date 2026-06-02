//
//  ProfileEmailTokenViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailTokenDisplayLogic: AnyObject {
    func onLoad(viewModel: ProfileEmailToken.Load.ViewModel)
    func onSave(viewModel: ProfileEmailToken.Save.ViewModel)
    func onSave(rows: [MainTableRow])
}


class ProfileEmailTokenViewController: MainBaseViewController, ProfileEmailTokenDisplayLogic {
  
    
    // Var's
    var interactor: ProfileEmailTokenBusinessLogic?
    var router: (NSObjectProtocol & ProfileEmailTokenRoutingLogic & ProfileEmailTokenDataPassing)?
    
    @IBOutlet var buttonSave: UIButtonBase!

  
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
        registerTableView()
        applyTableViewInsetsLg()
        addTapToDismissKeyboard()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = ProfileEmailToken.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ProfileEmailToken.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler save
    func save() {
        showLoading()
        let token = rows.inputTokenValue()
        let request = ProfileEmailToken.Save.Request(token: token)
        interactor?.save(request: request)
    }
    func onSave(viewModel: ProfileEmailToken.Save.ViewModel) {
        AppHaptics.success()
        reloadAllIfNeeded()
        navigationController?.popToRootViewController(animated: true)
    }
    func onSave(rows: [MainTableRow]) {
        hideLoading()
        self.rows = rows
        tableView?.reloadData()
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        let token = rows.inputTokenValue()
        buttonSave.isEnabled = token.count == 4
        if token.count == 4 {
            self.view.endEditing(true)
        }
    }
    
    
    // Handler loading
    func showLoading() {
        self.buttonSave.isEnabled = false
    }
    func hideLoading() {
        self.buttonSave.isEnabled = true
    }
    
    
    // Handler actions
    @IBAction func didSave() {
        AppHaptics.tap()
        save()
    }
    
    
    // Hook
    override
    func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputToken:
            (cell as? InputTokenCell)?.delegate = self
        default:
            break
        }
    }
    
}
