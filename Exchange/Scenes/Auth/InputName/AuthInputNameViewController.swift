//
//  AuthInputNameViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 13/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputNameDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthInputName.Load.ViewModel)
    func onSave(viewModel: AuthInputName.Save.ViewModel)
}


class AuthInputNameViewController: MainBaseViewController, AuthInputNameDisplayLogic {
  
    
    // Var's
    var interactor: AuthInputNameBusinessLogic?
    var router: (NSObjectProtocol & AuthInputNameRoutingLogic & AuthInputNameDataPassing)?
    
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
        
    }
    
    
    // Handler load
    func load() {
        let request = AuthInputName.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthInputName.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonSave()
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.handlerProgress()
        }
    }
    
    
    
    // Handler save
    func save() {
        
        if rowsIsValid() {
            showLoading()
            let name = rows.inputTextValue(identifier: .Name)
            let request = AuthInputName.Save.Request(name: name)
            interactor?.save(request: request)
        }
        
    }
    func onSave(viewModel: AuthInputName.Save.ViewModel) {
        hideLoading()
        performSegue(withIdentifier: "Next", sender: nil)
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        buttonSave.isEnabled = !rowsIsEmpty()
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
        if let nav = parent?.parent as? AuthMainViewController {
            nav.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func didSave() {
        AppHaptics.tap()
        save()
    }
    
    
    // Hook
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
