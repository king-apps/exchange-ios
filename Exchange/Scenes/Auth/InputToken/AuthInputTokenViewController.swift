//
//  AuthInputTokenViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputTokenDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthInputToken.Load.ViewModel)
    func onSave(viewModel: AuthInputToken.Save.ViewModel)
    func onSave(rows: [MainTableRow])
}


class AuthInputTokenViewController: AuthMainBaseViewController, AuthInputTokenDisplayLogic {
  
    
    // Var's
    var interactor: AuthInputTokenBusinessLogic?
    var router: (NSObjectProtocol & AuthInputTokenRoutingLogic & AuthInputTokenDataPassing)?
    
    @IBOutlet var labelDescription: UILabel!
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
        handlerProgress()
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        addTapToDismissKeyboard()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        AppAnalytics.shared.log(.authInputTokenViewed)
    }
    
    
    // Handler load
    func load() {
        let request = AuthInputToken.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthInputToken.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        
        labelDescription.text = viewModel.description
        handlerButtonSave()
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.showProgress()
            nav.handlerProgress()
        }
    }
    
    
    // Back
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // Save
    func save() {
        showLoading()
        let token = rows.inputTokenValue()
        let request = AuthInputToken.Save.Request(token: token)
        interactor?.save(request: request)
    }
    func onSave(viewModel: AuthInputToken.Save.ViewModel) {
        AppHaptics.success()
        hideLoading()
        performSegue(withIdentifier: "Next", sender: nil)
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
    @IBAction func didBack() {
        AppHaptics.tap()
        back()
    }
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
