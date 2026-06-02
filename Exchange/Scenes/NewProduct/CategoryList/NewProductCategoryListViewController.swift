//
//  NewProductCategoryListViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductCategoryListDisplayLogic: AnyObject {
    func onLoad(viewModel: NewProductCategoryList.Load.ViewModel)
    func onSearch(viewModel: NewProductCategoryList.Search.ViewModel)
    func onSearch(error: String)
    func onSave(viewModel: NewProductCategoryList.Save.ViewModel)
    func onSave(error: String)
}


class NewProductCategoryListViewController: MainBaseViewController, NewProductCategoryListDisplayLogic {
  
    
    // Var's
    var interactor: NewProductCategoryListBusinessLogic?
    var router: (NSObjectProtocol & NewProductCategoryListRoutingLogic & NewProductCategoryListDataPassing)?

  
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
        if let nav = parent?.parent as? NewProductMainViewController {
            nav.setThemeColor(color: nil)
        }
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let height = tableView?.bounds.height ?? 300
        let request = NewProductCategoryList.Load.Request(height: height)
        interactor?.load(request: request)
    }
    func onLoad(viewModel: NewProductCategoryList.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        search()
    }
    
    
    // Handler search
    func search() {
        let request = NewProductCategoryList.Search.Request()
        interactor?.search(request: request)
    }
    func onSearch(viewModel: NewProductCategoryList.Search.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    func onSearch(error: String) {
        displayAlert(nil, message: error)
    }
    
    
    // Handler save
    func save(row: Int) {
        let request = NewProductCategoryList.Save.Request(row: row)
        interactor?.save(request: request)
    }
    func onSave(viewModel: NewProductCategoryList.Save.ViewModel) {
        print("NEXT")
        performSegue(withIdentifier: "Next", sender: nil)
    }
    func onSave(error: String) {
        displayAlert(nil, message: error)
    }
    
    
    // Hooks
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .default(var model):
            unSelectDefaultRows(ignoreIndexPath: indexPath)
            model.style = .selected
            rows[indexPath.row] = .default(model)
            tableView?.reloadRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration * 2, execute: {
                self.save(row: indexPath.row)
            })
        default:
            break
        }
    }
    
    
}
