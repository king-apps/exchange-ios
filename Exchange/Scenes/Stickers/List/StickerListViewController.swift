//
//  StickerListViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerListDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerList.Load.ViewModel)
    func onFetch(viewModel: StickerList.Fetch.ViewModel)
    func onUpdateCollected(viewModel: StickerList.UpdateCollected.ViewModel)
    func onCreateProduct(viewModel: StickerList.CreateProduct.ViewModel)
    func onCreateProductError(error: String)
    func onSave(viewModel: StickerList.Save.ViewModel)
    func onProduct(viewModel: StickerList.PProduct.ViewModel)
}


class StickerListViewController: MainBaseViewController, StickerListDisplayLogic {
  
    
    // Var's
    var interactor: StickerListBusinessLogic?
    var router: (NSObjectProtocol & StickerListRoutingLogic & StickerListDataPassing)?
    var selectedStickerIdForProduct: Int?
    
    @IBOutlet var inputTextKeywords: UITextField!
    @IBOutlet var viewFilterBadge: UIView!
    @IBOutlet var buttonAds: UIButtonBase!
    var timer: Timer?

  
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
        setupAd()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
        viewFilterBadge.isHidden = !LocalConfig.shared.filterStickerIsActive()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Sticker.List.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
        tableView?.keyboardDismissMode = .onDrag
        
        inputTextKeywords.placeholder = "Sticker.List.Search.Placeholder".localized
        inputTextKeywords.delegate = self
        inputTextKeywords.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)

        viewFilterBadge.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: .reloadProductList, object: nil)
    }
    
    
    // Setup ad
    func setupAd() {
        if hasAd() {
            adBannerView?.load(.stickerListBanner, viewController: self)
        }
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let height: CGFloat = tableView?.bounds.height ?? self.view.bounds.height
        let request = StickerList.Load.Request(height: height)
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerList.Load.ViewModel) {
        inputTextKeywords.text = viewModel.keywords
        rows = viewModel.rows
        tableView?.reloadData()
        fetch()
    }
    
    
    // Handler fetch
    @objc
    func fetch() {
        let request = StickerList.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: StickerList.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler update collected
    func updateCollected(id: Int, operation: StickerList.CollectedOperation) {
        let request = StickerList.UpdateCollected.Request(id: id, operation: operation)
        interactor?.updateCollected(request: request)
    }
    func onUpdateCollected(viewModel: StickerList.UpdateCollected.ViewModel) {
        let previousRowCount = rows.count
        rows = viewModel.rows
        
        if let error = viewModel.error {
            AppHaptics.error()
            displayAlert(nil, message: error)
        }
        
        guard let stickerIndexPath = indexPathForSticker(id: viewModel.id) else {
            tableView?.reloadData()
            return
        }
        
        let indexPaths = uniqueIndexPaths(
            indexPathsForStatisticRows()
                + [stickerIndexPath]
                + indexPathsForStickerCategoryHeader(id: viewModel.id)
        )
        guard previousRowCount == rows.count, indexPaths.allSatisfy({ $0.row < previousRowCount }) else {
            tableView?.reloadData()
            return
        }
        
        UIView.performWithoutAnimation {
            tableView?.reloadRows(at: indexPaths, with: .none)
            tableView?.layoutIfNeeded()
        }
    }
    
    private func indexPathsForStatisticRows() -> [IndexPath] {
        rows.enumerated().compactMap { index, row in
            guard case .productProgress(let model) = row else { return nil }
            
            switch model.identifier {
            case .collected, .duplicated:
                return IndexPath(row: index, section: 0)
            default:
                return nil
            }
        }
    }
    
    private func uniqueIndexPaths(_ indexPaths: [IndexPath]) -> [IndexPath] {
        Array(Set(indexPaths)).sorted {
            if $0.section == $1.section {
                return $0.row < $1.row
            }
            
            return $0.section < $1.section
        }
    }
    
    private func indexPathForSticker(id: Int) -> IndexPath? {
        for (index, row) in rows.enumerated() {
            guard case .stickerList(let model) = row else { continue }
            
            if model.items.contains(where: { $0.id == id }) {
                return IndexPath(row: index, section: 0)
            }
        }
        
        return nil
    }
    
    private func indexPathsForStickerCategoryHeader(id: Int) -> [IndexPath] {
        var categoryHeaderIndexPath: IndexPath?
        
        for (index, row) in rows.enumerated() {
            switch row {
            case .stickerCategoryList:
                categoryHeaderIndexPath = IndexPath(row: index, section: 0)
            case .stickerList(let model):
                if model.items.contains(where: { $0.id == id }) {
                    return categoryHeaderIndexPath.map { [$0] } ?? []
                }
            default:
                break
            }
        }
        
        return []
    }
    
    
    // Handler create product
    func createProduct(id: Int, image: UIImage) {
        view.isUserInteractionEnabled = false
        let request = StickerList.CreateProduct.Request(id: id, image: image)
        interactor?.createProduct(request: request)
    }
    func onCreateProduct(viewModel: StickerList.CreateProduct.ViewModel) {
        view.isUserInteractionEnabled = true
        rows = viewModel.rows
        tableView?.reloadData()
        AppHaptics.success()
    }
    func onCreateProductError(error: String) {
        view.isUserInteractionEnabled = true
        AppHaptics.error()
        displayAlert(nil, message: error)
    }
    
    // Handler save
    func save() {
        let request = StickerList.Save.Request(keywords: self.inputTextKeywords.text ?? "")
        interactor?.save(request: request)
    }
    func onSave(viewModel: StickerList.Save.ViewModel) {
        fetch()
        viewFilterBadge.isHidden = !LocalConfig.shared.filterStickerIsActive()
    }
    
    @objc private func textFieldDidEditingChanged(_ textField: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.45, repeats: false) { [weak self] _ in
            self?.save()
        }
    }
    
    
    // Handler product
    func product(id: Int) {
        let request = StickerList.PProduct.Request(id: id)
        interactor?.product(request: request)
    }
    func onProduct(viewModel: StickerList.PProduct.ViewModel) {
        performSegue(withIdentifier: "Product", sender: nil)
    }
    
    
    
    // Handler actions
    @IBAction func didInfo() {
        router?.routeToStickerInfo()
    }
    
    
    // Hooks
    override func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .stickerList:
            (cell as? StickerListCell)?.delegate = self
            break
        default:
            break
        }
    }
    
    
}
