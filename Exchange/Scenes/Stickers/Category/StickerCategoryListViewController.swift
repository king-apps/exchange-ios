//
//  StickerCategoryListViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerCategoryListDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerCategoryList.Load.ViewModel)
    func onFetch(viewModel: StickerCategoryList.Fetch.ViewModel)
    func onSave(viewModel: StickerCategoryList.Save.ViewModel)
    func onClear(viewModel: StickerCategoryList.Clear.ViewModel)
}


class StickerCategoryListViewController: MainBaseViewController, StickerCategoryListDisplayLogic {
  
    
    // Var's
    var interactor: StickerCategoryListBusinessLogic?
    var router: (NSObjectProtocol & StickerCategoryListRoutingLogic & StickerCategoryListDataPassing)?
    
    @IBOutlet var buttonClear: UIButtonBase!

  
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
    
    // Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reloadFilterListIfNeeded()
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
        let request = StickerCategoryList.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerCategoryList.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = StickerCategoryList.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: StickerCategoryList.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonClear()
    }
    
    
    // Handler save
    func save(row: Int) {
        let request = StickerCategoryList.Save.Request(row: row)
        interactor?.save(request: request)
    }
    func onSave(viewModel: StickerCategoryList.Save.ViewModel) {
        rows = viewModel.rows
        DispatchQueue.main.async {
            self.tableView?.reloadRows(at: [IndexPath(row: viewModel.row, section: 0)], with: .automatic)
            self.handlerButtonClear()
        }
    }
    
    
    // Handler clear
    func clear() {
        let request = StickerCategoryList.Clear.Request()
        interactor?.clear(request: request)
    }
    func onClear(viewModel: StickerCategoryList.Clear.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonClear()
    }
    
    
    // Handler button save
    func handlerButtonClear() {
        DispatchQueue.main.async {
            let count = self.rows.reduce(0) { result, row in
                guard case .default(let model) = row, model.style == .selected else {
                    return result
                }
                
                return result + 1
            }
            
            let suffix = count > 0 ? " (\(count))" : ""
            let title = "StickerFilter.Button.Clear".localized+suffix
            self.buttonClear.setTitle(title, for: .normal)
            self.buttonClear.isEnabled = count > 0
        }
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    @IBAction func didClear() {
        clear()
    }
    
    
    // Handler hooks
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case.default:
            AppHaptics.selection()
            save(row: indexPath.row)
            break
        default:
            break
        }
    }
    
    
}
