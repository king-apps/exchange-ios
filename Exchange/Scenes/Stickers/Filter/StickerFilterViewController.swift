//
//  StickerFilterViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerFilterDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerFilter.Load.ViewModel)
    func onFetch(viewModel: StickerFilter.Fetch.ViewModel)
    func onSave(viewModel: StickerFilter.Save.ViewModel)
}

protocol StickerFilterDelegate {
    func stickerFilterDidClose()
}

class StickerFilterViewController: MainBaseViewController, StickerFilterDisplayLogic {
  
    
    // Var's
    var interactor: StickerFilterBusinessLogic?
    var router: (NSObjectProtocol & StickerFilterRoutingLogic & StickerFilterDataPassing)?
    
    var delegate: StickerFilterDelegate?

  
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
        setupNotifications()
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
    
    // Disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.stickerFilterDidClose()
    }
    
    
    // Setup inputs
    func setupInputs() {
        //applyTableViewInsetsLg()
        registerTableView()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Setup notifications
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: .reloadFilterList, object: nil)
    }
    
    
    // Handler load
    func load() {
        let request = StickerFilter.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerFilter.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    @objc
    func fetch() {
        let request = StickerFilter.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: StickerFilter.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler save
    func save() {
        
        let collected = rows.switchValue(identifier: .collected)
        let missing = rows.switchValue(identifier: .missing)
        let duplicated = rows.switchValue(identifier: .duplicated)
        let published = rows.switchValue(identifier: .published)
        
        let request = StickerFilter.Save.Request(
            collected: collected,
            missing: missing,
            duplicated: duplicated,
            published: published
        )
        interactor?.save(request: request)
        
    }
    func onSave(viewModel: StickerFilter.Save.ViewModel) {
        
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    
 
    // Hooks
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputSelect(let model):
            if model.identifier == .category {
                performSegue(withIdentifier: "Category", sender: nil)
            }
            break
        default:
            break
        }
    }
    override func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .switch:
            (cell as? SwitchCell)?.delegate = self
            break
        default:
            break
        }
    }
 
    
}
