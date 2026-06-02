//
//  ProfileEmailViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailDisplayLogic: AnyObject {
    func onLoad(viewModel: ProfileEmail.Load.ViewModel)
    func onSave(viewModel: ProfileEmail.Save.ViewModel)
    func onSave(error: String)
}


class ProfileEmailViewController: MainBaseViewController, ProfileEmailDisplayLogic {
  
    
    // Var's
    var interactor: ProfileEmailBusinessLogic?
    var router: (NSObjectProtocol & ProfileEmailRoutingLogic & ProfileEmailDataPassing)?
    
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
        //self.navigationItem.title = "Profile.Anonymous.SignIn".localized
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
        let request = ProfileEmail.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ProfileEmail.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonSave()
    }
    
    
    // Handler button send
    func handlerButtonSave() {
        buttonSave.isEnabled = !rowsIsEmpty()
    }
    
    
    // Handler save
    func save() {
        if rowsIsValid() {
            buttonSave.showLoading()
            let email = rows.inputTextValue(identifier: .Email)
            let request = ProfileEmail.Save.Request(email: email)
            interactor?.save(request: request)
        }
    }
    func onSave(viewModel: ProfileEmail.Save.ViewModel) {
        buttonSave.hideLoading()
        performSegue(withIdentifier: "Token", sender: nil)
    }
    func onSave(error: String) {
        buttonSave.hideLoading()
        displayAlert(nil, message: error)
    }
    
    
    // Handler actions
    @IBAction func didSave() {
        save()
    }
    
    
    // Hooks
    override
    func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputText:
            (cell as? InputTextCell)?.delegate = self
        default:
            break
        }
    }
    
    
}
