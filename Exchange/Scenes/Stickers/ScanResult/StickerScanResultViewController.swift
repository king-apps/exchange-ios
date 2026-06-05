//
//  StickerScanResultViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher


protocol StickerScanResultViewControllerDelegate: AnyObject {
    func didDismissResult()
}


protocol StickerScanResultDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerScanResult.Load.ViewModel)
    func onFetch(viewModel: StickerScanResult.Fetch.ViewModel)
    func onSave(viewModel: StickerScanResult.Save.ViewModel)
}


class StickerScanResultViewController: MainBaseViewController, StickerScanResultDisplayLogic {
  
    
    // Var's
    var interactor: StickerScanResultBusinessLogic?
    var router: (NSObjectProtocol & StickerScanResultRoutingLogic & StickerScanResultDataPassing)?
    weak var delegate: StickerScanResultViewControllerDelegate?
    private var hasNotifiedDismiss = false
    private var stickerColor = AppTheme.Colors.brandPrimary500
    private var categoryUrl: String?
    
    
    @IBOutlet var viewCard: UIView!
    @IBOutlet var imageViewSticker: UIImageView!
    
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    
    @IBOutlet var viewName: UIView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageViewGradient: UIView!
    
    @IBOutlet var viewLabelCount: UIView!
    @IBOutlet var labelCount: UILabel!
    @IBOutlet var imageViewCategory: UIImageView!
    
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notifyDismiss()
    }
    
    
    // Setup inputs
    func setupInputs() {
        viewCard.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker.layer.cornerRadius = AppTheme.Radius.lg
        imageViewSticker.backgroundColor = AppTheme.Colors.backgroundDisabled
        viewLabelCount.layer.cornerRadius = viewLabelCount.bounds.height / 2
        imageViewCategory.layer.cornerRadius = imageViewCategory.bounds.height / 2
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = StickerScanResult.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerScanResult.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = StickerScanResult.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: StickerScanResult.Fetch.ViewModel) {
        stickerColor = viewModel.color
        categoryUrl = viewModel.categoryUrl
        setupSaveButton(item: viewModel.item)
        emitDetectedFeedback(item: viewModel.item)
        
        setupSticker(
            item: viewModel.item,
            color: stickerColor,
            categoryUrl: categoryUrl
        )
        
    }
    
    
    // Handler save
    func save() {
        buttonSave.isUserInteractionEnabled = false
        let request = StickerScanResult.Save.Request()
        interactor?.save(request: request)
    }
    func onSave(viewModel: StickerScanResult.Save.ViewModel) {
        buttonSave.isUserInteractionEnabled = true
        
        if let error = viewModel.error {
            AppHaptics.error()
            displayAlert(nil, message: error)
            return
        }
        
        if let item = viewModel.item {
            setupSaveButton(item: item)
            setupSticker(
                item: item,
                color: stickerColor,
                categoryUrl: categoryUrl
            )
        }
        
        AppHaptics.success()
        reloadProductListIfNeeded()
        dismiss(animated: true)
    }
    
    
    // Handler actions
    @IBAction func didSave() {
        save()
    }
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    private func notifyDismiss() {
        guard hasNotifiedDismiss == false else { return }
        
        hasNotifiedDismiss = true
        delegate?.didDismissResult()
    }
    
    
    // Handler sticker
    private func setupSticker(item: StickerListCell.Item, color: UIColor, categoryUrl: String?) {
        viewCard.isHidden = false
        viewCard.tag = item.id
        
        setupCategoryImage(categoryUrl)
        
        imageViewGradient.tintColor = color
        imageViewSticker.backgroundColor = stickerBackgroundColor(for: item, color: color)
        imageViewSticker.image = nil
        imageViewSticker.kf.cancelDownloadTask()
        
        if let image = item.image {
            imageViewSticker.image = image
            imageViewSticker.contentMode = .scaleAspectFill
        }
        else if let imageUrl = URL(string: item.imageUrl), item.imageUrl.isEmpty == false {
            imageViewSticker.kf.setImage(with: imageUrl)
            imageViewSticker.contentMode = .scaleAspectFill
        }
        else {
            imageViewSticker.contentMode = .center
        }
        
        labelTitle.text = item.title
        labelTitle.textColor = stickerTextColor(for: item)
        labelDescription.text = item.description
        labelDescription.textColor = labelTitle.textColor
        
        viewLabelCount.backgroundColor = item.collected > 1 ? AppTheme.Colors.error500 : .clear
        labelCount.text = item.collected >= 10 ? "\(item.collected)" : "\(item.collected)x"
        labelCount.textColor = stickerCountColor(for: item)
        
        viewName.isHidden = item.imageUrl.isEmpty && item.image == nil
        viewTitle.isHidden = !viewName.isHidden
        labelName.text = "\(item.title) \(item.description)"
        
        imageViewSticker.isUserInteractionEnabled = false
        viewTitle.isUserInteractionEnabled = false
        labelTitle.isUserInteractionEnabled = false
        labelDescription.isUserInteractionEnabled = false
        labelCount.isUserInteractionEnabled = false
        viewName.isUserInteractionEnabled = false
        labelName.isUserInteractionEnabled = false
    }
    private func hasCollectedSticker(_ item: StickerListCell.Item) -> Bool {
        item.collected > 0
    }
    private func stickerBackgroundColor(for item: StickerListCell.Item, color: UIColor) -> UIColor {
        hasCollectedSticker(item) ? color : AppTheme.Colors.backgroundDisabled
    }
    private func stickerTextColor(for item: StickerListCell.Item) -> UIColor {
        hasCollectedSticker(item) ? .white : AppTheme.Colors.textOnSurfaceSecondary
    }
    private func stickerCountColor(for item: StickerListCell.Item) -> UIColor {
        item.collected > 1 ? .white : AppTheme.Colors.textOnSurfaceDisabled
    }
    private func setupCategoryImage(_ categoryUrl: String?) {
        guard let categoryUrl, categoryUrl.isEmpty == false else {
            imageViewCategory.isHidden = true
            return
        }
        
        imageViewCategory.isHidden = false
        imageViewCategory.clipsToBounds = true
        imageViewCategory.image = UIImage(named: categoryUrl)
        imageViewCategory.contentMode = .scaleAspectFit
    }
    private func setupSaveButton(item: StickerListCell.Item) {
        let hasSticker = hasCollectedSticker(item)
        let title = hasSticker
            ? "Sticker.Scan.Result.Button.Duplicate".localized
            : "Sticker.Scan.Result.Button.New".localized
        
        buttonSave.backgroundColor = hasSticker ? AppTheme.Colors.error500 : AppTheme.Colors.success500
        buttonSave.setTitle(title, for: .normal)
        buttonSave.setTitle(title, for: .disabled)
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.tintColor = .white
    }
    private func emitDetectedFeedback(item: StickerListCell.Item) {
        if hasCollectedSticker(item) {
            AppHaptics.error()
        }
        else {
            AppHaptics.success()
        }
    }
    
    
}
