//
//  NewProductMainViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductMainDisplayLogic: AnyObject {
    func onLoad(viewModel: NewProductMain.Load.ViewModel)
    func onSave(viewModel: NewProductMain.Save.ViewModel)
}


class NewProductMainViewController: MainBaseViewController, NewProductMainDisplayLogic {
  
    
    // Var's
    var interactor: NewProductMainBusinessLogic?
    var router: (NSObjectProtocol & NewProductMainRoutingLogic & NewProductMainDataPassing)?
    
    @IBOutlet var viewProgressStep1: UIView!
    @IBOutlet var viewProgressStep2: UIView!
    @IBOutlet var viewProgressStep3: UIView!
    var themeColor: UIColor = AppTheme.Colors.brandPrimary500
    var listViewProgress = [UIView]()

  
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
        self.title = "NewProduct.Title".localized
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    // Setup inputs
    func setupInputs() {
        
        let chevron = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: chevron, style: .plain, target: self, action: #selector(didBack))
        backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = backButton
        
        listViewProgress = [
            viewProgressStep1,
            viewProgressStep2,
            viewProgressStep3
        ]
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = NewProductMain.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: NewProductMain.Load.ViewModel) {
        
    }
    
    
    // Handler save
    func save(product: Product?) {
        let request = NewProductMain.Save.Request(product: product)
        interactor?.save(request: request)
    }
    func onSave(viewModel: NewProductMain.Save.ViewModel) {
        // 
    }
    
    
    // Handler theme color
    func setThemeColor(color: UIColor?) {
        if let color = color {
            themeColor = color
        }
        else {
            themeColor = AppTheme.Colors.brandPrimary500
        }
        handlerProgress()
    }
    
    
    // Handler progress
    func handlerProgress() {
        
        let color = UIColor.secondarySystemBackground
        
        if let nav = self.children.first as? UINavigationController {
            for i in 0 ..< listViewProgress.count {
                UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0) {
                    if i < nav.children.count {
                        self.listViewProgress[i].backgroundColor = self.themeColor
                    }
                    else {
                        self.listViewProgress[i].backgroundColor = color
                    }
                }
            }
        }
    }
    
    
    // Handler back
    @objc
    func didBack() {

        if let nav = self.children.first as? UINavigationController {
            if nav.children.count > 1 {
                nav.popViewController(animated: true)
            }
            else {
                navigationController?.popViewController(animated: true)
            }
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
