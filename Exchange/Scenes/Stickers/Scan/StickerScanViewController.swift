//
//  StickerScanViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerScanDisplayLogic: AnyObject {
    func onLoad(viewModel: StickerScan.Load.ViewModel)
}


class StickerScanViewController: MainBaseViewController, StickerScanDisplayLogic {
  
    
    // Var's
    var interactor: StickerScanBusinessLogic?
    var router: (NSObjectProtocol & StickerScanRoutingLogic & StickerScanDataPassing)?
    
    @IBOutlet var scannerContainerView: UIView!

  
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
        let request = StickerScan.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: StickerScan.Load.ViewModel) {
        
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    
    
}
