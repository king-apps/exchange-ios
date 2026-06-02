//
//  MyProductInputNameViewController.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 2/23/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol MyProductInputNameDisplayLogic: AnyObject {
    func onLoad(viewModel: MyProductInputName.Load.ViewModel)
    func onSave(viewModel: MyProductInputName.Save.ViewModel)
    func onSaveError(error: String)
}


class MyProductInputNameViewController: MainBaseViewController, MyProductInputNameDisplayLogic {
  
    
    // Var's
    var interactor: MyProductInputNameBusinessLogic?
    var router: (NSObjectProtocol & MyProductInputNameRoutingLogic & MyProductInputNameDataPassing)?
    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var imageViewStickerTop: UIImageView!
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var imageviewStickerBottom: UIImageView!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet var labelCode: UILabel!
    @IBOutlet weak var buttonSave: UIButtonBase!

  
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
        inputName.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "MyProduct.InputName.Title".localized
        
        if let nav = parent?.parent as? NewProductMainViewController {
            nav.handlerProgress()
        }
    }
    
    
    // Setup inputs
    func setupInputs() {
        
        inputName.delegate = self
        inputName.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        inputName.placeholder = "MyProduct.InputName.Placeholder".localized
        
        handlerButtonSave()
        handlerCharacterLength()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = MyProductInputName.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MyProductInputName.Load.ViewModel) {
        labelCode.text = viewModel.code
        buttonSave.backgroundColor = viewModel.color
        
        imageViewStickerTop.tintColor = viewModel.color
        viewTop.backgroundColor = viewModel.color
        imageviewStickerBottom.tintColor = viewModel.color
        viewBottom.backgroundColor = viewModel.color
        
        if let nav = parent?.parent as? NewProductMainViewController {
            nav.setThemeColor(color: viewModel.color)
        }
    }
    
    
    // Handler save
    func save() {
        let request = MyProductInputName.Save.Request(name: inputName.text!)
        interactor?.save(request: request)
    }
    func onSave(viewModel: MyProductInputName.Save.ViewModel) {
        buttonSave.hideLoading()
        performSegue(withIdentifier: "Next", sender: nil)
    }
    func onSaveError(error: String) {
        buttonSave.hideLoading()
        displayAlert(nil, message: error)
    }
    
    
    // Handler character count
    func handlerCharacterLength() {
        /*
        if inputName.text!.count == kProductInputNameMaxCharacterLength {
            inputName.endEditing(true)
            didSave()
        }
         */
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        buttonSave.isEnabled = (
            inputName.text!.count > 0
        )
    }
    
    
    // Handler actions
    @IBAction func didSave() {
       buttonSave.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.save()
        }
        
    }
    
    
}
