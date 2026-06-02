//
//  ProfileNameViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileNameDisplayLogic: AnyObject {
    func onLoad(viewModel: ProfileName.Load.ViewModel)
    func onSave(viewModel: ProfileName.Save.ViewModel)
    func onSave(error: String)
}


class ProfileNameViewController: MainBaseViewController, ProfileNameDisplayLogic {
  
    
    // Var's
    var interactor: ProfileNameBusinessLogic?
    var router: (NSObjectProtocol & ProfileNameRoutingLogic & ProfileNameDataPassing)?
    
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
        let request = ProfileName.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ProfileName.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonSave()
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        buttonSave.isEnabled = !rowsIsEmpty()
    }
    
    
    // Handler save
    func save() {
        if rowsIsValid() {
            buttonSave.showLoading()
            let name = rows.inputTextValue(identifier: .Name)
            let request = ProfileName.Save.Request(name: name)
            interactor?.save(request: request)
        }
    }
    func onSave(viewModel: ProfileName.Save.ViewModel) {
        reloadProfileIfNeeded()
        navigationController?.popViewController(animated: true)
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
