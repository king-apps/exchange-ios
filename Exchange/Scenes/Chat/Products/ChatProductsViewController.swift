//
//  ChatProductsViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatProductsDisplayLogic: AnyObject {
    func onLoad(viewModel: ChatProducts.Load.ViewModel)
    func onFetch(viewModel: ChatProducts.Fetch.ViewModel)
    func onProduct(viewModel: ChatProducts.Product.ViewModel)
}


class ChatProductsViewController: MainBaseViewController, ChatProductsDisplayLogic {
  
    
    // Var's
    var interactor: ChatProductsBusinessLogic?
    var router: (NSObjectProtocol & ChatProductsRoutingLogic & ChatProductsDataPassing)?

  
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
        self.navigationItem.title = "Chat.Products.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let height = tableView?.bounds.height ?? 300
        let request = ChatProducts.Load.Request(height: height)
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ChatProducts.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = ChatProducts.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: ChatProducts.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler product
    func product(productId: Int) {
        let request = ChatProducts.Product.Request(productId: productId)
        interactor?.product(request: request)
    }
    func onProduct(viewModel: ChatProducts.Product.ViewModel) {
        performSegue(withIdentifier: "Product", sender: nil)
    }
    
    
    // Hook
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case let .product(product):
            self.product(productId: product.id)
            break
        default:
            break
        }
    }
    
}
