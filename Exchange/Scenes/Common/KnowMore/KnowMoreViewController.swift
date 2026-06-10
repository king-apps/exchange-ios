//
//  KnowMoreViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol KnowMoreDisplayLogic: AnyObject {
    func onLoad(viewModel: KnowMore.Load.ViewModel)
    func onFetch(viewModel: KnowMore.Fetch.ViewModel)
    func onPurchase(viewModel: KnowMore.Purchase.ViewModel)
    func onPurchase(error: String)
}


protocol knowMoreDelegate: AnyObject {
    func knowMoreDidtapAction(option: KnowMoreOption?)
    func knowMoreDidClose(option: KnowMoreOption?)
}


class KnowMoreViewController: MainBaseViewController, KnowMoreDisplayLogic {
  
    
    // Var's
    var interactor: KnowMoreBusinessLogic?
    var router: (NSObjectProtocol & KnowMoreRoutingLogic & KnowMoreDataPassing)?
    
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSubtitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var buttonAction: UIButtonBase!
    var delegate: knowMoreDelegate?
    var sheetHeightDidChange: (() -> Void)?
    var buttonIsPurchase: Bool = false
    var option: KnowMoreOption?
    
  
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
        
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = KnowMore.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: KnowMore.Load.ViewModel) {
        
        self.option = viewModel.option
        
        if viewModel.icon == .none {
            imageViewIcon.removeFromSuperview()
        }
        else {
            imageViewIcon.image = AppTheme.icon(viewModel.icon)
            imageViewIcon.tintColor = viewModel.iconColor
        }
        
        labelTitle.text = viewModel.title
        labelSubtitle.text = viewModel.subtitle
        labelDescription.text = viewModel.description
        buttonAction.setTitle(viewModel.buttonTitle, for: .normal)
        if !viewModel.buttonIsEnabled {
            buttonAction.showLoading()
        }
        sheetHeightDidChange?()
        
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = KnowMore.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: KnowMore.Fetch.ViewModel) {
        
        self.buttonIsPurchase = viewModel.buttonIsPurchase
        DispatchQueue.main.async(execute: {
            self.buttonAction.hideLoading()
            self.buttonAction.setTitle(viewModel.buttonTitle, for: .normal)
            self.buttonAction.isEnabled = viewModel.buttonIsEnabled
        })
        
    }
    
    
    // Handler purchase
    func purchase() {
        buttonAction.showLoading(text: "App.Sending".localized)
        let request = KnowMore.Purchase.Request()
        interactor?.purchase(request: request)
    }
    func onPurchase(viewModel: KnowMore.Purchase.ViewModel) {
        dismiss(animated: true) {
            self.buttonAction.hideLoading()
            self.delegate?.knowMoreDidtapAction(option: self.option)
        }
    }
    func onPurchase(error: String) {
        buttonAction.hideLoading()
        displayAlert(nil, message: error)
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true) {
            self.delegate?.knowMoreDidClose(option: self.option)
        }
    }
    @IBAction func didAction() {
        
        if self.buttonIsPurchase {
            self.purchase()
        }
        else {
            dismiss(animated: true) {
                self.delegate?.knowMoreDidtapAction(option: self.option)
            }
        }
    }
    
}


extension KnowMoreViewController {
    
    func preferredSheetHeight(maximumHeight: CGFloat) -> CGFloat {
        view.layoutIfNeeded()
        
        let width = view.bounds.width > 0 ? view.bounds.width : UIScreen.main.bounds.width
        let contentWidth = max(width - 48, 0)
        let titleWidth = max(width - 128, 0)
        
        let titleHeight = labelTitle.sizeThatFits(
            CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude)
        ).height
        let subtitleHeight = labelSubtitle.sizeThatFits(
            CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude)
        ).height
        let descriptionHeight = labelDescription.sizeThatFits(
            CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude)
        ).height
        
        let headerHeight = view.safeAreaInsets.top + 32 + titleHeight
        let bodyHeight = subtitleHeight + 8 + descriptionHeight
        let footerHeight = 24 + 48 + view.safeAreaInsets.bottom + 24
        let grabberHeight: CGFloat =  16
        let preferredHeight = ceil(headerHeight + bodyHeight + footerHeight + grabberHeight)
        
        return min(max(preferredHeight, 120), maximumHeight)
    }
    
}
