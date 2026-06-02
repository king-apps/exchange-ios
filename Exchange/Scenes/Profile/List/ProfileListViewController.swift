//
//  ProfileListViewController.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit


protocol ProfileListDisplayLogic: AnyObject {
    func onLoad(viewModel: ProfileList.Load.ViewModel)
    func onBoostStatus(viewModel: ProfileList.BoostStatus.ViewModel)
    func onFetch(viewModel: ProfileList.Fetch.ViewModel)
    func onSave(viewModel: ProfileList.Save.ViewModel)
    func onDeleteAccount(viewModel: ProfileList.DeleteAccount.ViewModel)
    func onLogout(viewModel: ProfileList.Logout.ViewModel)
    func onAvatar(viewModel: ProfileList.Avatar.ViewModel)
    func onAvatar(error: String)
}


class ProfileListViewController: MainBaseViewController, ProfileListDisplayLogic {
  
    
    // Var's
    var interactor: ProfileListBusinessLogic?
    var router: (NSObjectProtocol & ProfileListRoutingLogic & ProfileListDataPassing)?

  
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
        boostStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Profile.My.Section".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Setup notifications
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: .reloadProfile, object: nil)
    }
    
    
    // Handler load
    func load() {
        let request = ProfileList.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ProfileList.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler boost
    func boostStatus() {
        let request = ProfileList.BoostStatus.Request()
        interactor?.boostStatus(request: request)
    }
    func onBoostStatus(viewModel: ProfileList.BoostStatus.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    @objc
    func fetch() {
        let request = ProfileList.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: ProfileList.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler save
    func save() {
        let request = ProfileList.Save.Request(
            notificationMatch: rows.switchValue(identifier: .match),
            notificationMessage: rows.switchValue(identifier: .message)
        )
        interactor?.save(request: request)
    }
    func onSave(viewModel: ProfileList.Save.ViewModel) {
    
    }
    
    
    // Handler avatar
    // Handler avatar
    func handlerAvatar() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let didLibrary = UIAlertAction(title: "App.Library".localized, style: .default) { (action) in
            self.openLibary()
        }
        alert.addAction(didLibrary)
        let didCamera = UIAlertAction(title: "App.Camera".localized, style: .default) { (action) in
            self.openCamera()
        }
        alert.addAction(didCamera)
        let didClose = UIAlertAction(title: "App.Close".localized, style: .cancel) { (action) in
            
        }
        alert.addAction(didClose)
        present(alert, animated: true, completion: nil)
        
    }
    func openCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = false
        vc.delegate = self
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    func openLibary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.mediaTypes = ["public.image"]
        vc.allowsEditing = false
        vc.delegate = self
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    func avatar(image: UIImage) {
        let request = ProfileList.Avatar.Request(image: image)
        interactor?.avatar(request: request)
    }
    func onAvatar(viewModel: ProfileList.Avatar.ViewModel) {
        load()
    }
    func onAvatar(error: String) {
        displayAlert(nil, message: error)
    }
    
    
    // Handler delete account
    func confirmDeleteAccount() {
        let sheet = UIAlertController(
            title: "KnowMore.DeleteAccount.Title".localized,
            message: "KnowMore.DeleteAccount.Description".localized,
            preferredStyle: .actionSheet
        )
        sheet.addAction(
            UIAlertAction(
                title: "App.Cancel".localized,
                style: .cancel
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: "App.Delete".localized,
                style: .destructive,
                handler: { [weak self] _ in
                    self?.deleteAccount()
                }
            )
        )
        
        present(sheet, animated: true)
    }
    func deleteAccount() {
        let request = ProfileList.DeleteAccount.Request()
        interactor?.deleteAccount(request: request)
    }
    func onDeleteAccount(viewModel: ProfileList.DeleteAccount.ViewModel) {
        let alert = UIAlertController(
            title: "Profile.Actions.Delete.Success.Title".localized,
            message: "Profile.Actions.Delete.Success.Message".localized,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "Alert.Action.Close".localized,
                style: .default,
                handler: { [weak self] _ in
                    self?.routeToRoot()
                }
            )
        )
        present(alert, animated: true)
    }
    
    
    // Handler logout
    func confirmLogout() {
        let sheet = UIAlertController(
            title: "Profile.Actions.Logout.Confirm.Title".localized,
            message: "Profile.Actions.Logout.Confirm.Message".localized,
            preferredStyle: .actionSheet
        )
        sheet.addAction(
            UIAlertAction(
                title: "App.Cancel".localized,
                style: .cancel
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: "Profile.Actions.Logout.Confirm.Action".localized,
                style: .destructive,
                handler: { [weak self] _ in
                    self?.logout()
                }
            )
        )
        
        present(sheet, animated: true)
    }
    func logout() {
        let request = ProfileList.Logout.Request()
        interactor?.logout(request: request)
    }
    func onLogout(viewModel: ProfileList.Logout.ViewModel) {
        routeToRoot()
    }
    
    
    // Handler reset
    func confirmReset() {
        let sheet = UIAlertController(
            title: "Profile.Actions.Reset.Confirm.Title".localized,
            message: "Profile.Actions.Reset.Confirm.Message".localized,
            preferredStyle: .actionSheet
        )
        sheet.addAction(
            UIAlertAction(
                title: "App.Cancel".localized,
                style: .cancel
            )
        )
        sheet.addAction(
            UIAlertAction(
                title: "Profile.Actions.Reset.Confirm.Action".localized,
                style: .destructive,
                handler: { [weak self] _ in
                    self?.logout()
                }
            )
        )
        
        present(sheet, animated: true)
    }
    
    
    // Route to root
    func routeToRoot() {
        guard let destinationVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() else {
            return
        }
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
        else { return }
        sceneDelegate.setRootViewController(destinationVC)
    }
    
    
    // Hooks
    override func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .switch:
            (cell as? SwitchCell)?.delegate = self
            break
        default:
            break
        }
    }
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .default(let model):
            switch model.identifier {
            case .signIn:
                if model.style == .disabled { return }
                performSegue(withIdentifier: "Email", sender: nil)
                break
            case .picture:
                if model.style == .disabled { return }
                handlerAvatar()
                break
            case .name:
                if model.style == .disabled { return }
                performSegue(withIdentifier: "Name", sender: nil)
                break
            case .ratingApp:
                ratingApp()
                break
            case .shareApp:
                shareApp()
                break
            case .terms:
                performSegue(withIdentifier: "Terms", sender: nil)
                break
            case .privacy:
                performSegue(withIdentifier: "Privacy", sender: nil)
                break
            case .deleteAccount:
                router?.routeToDeleteAccount()
                break
            case .logoutApp:
                confirmLogout()
                break
            case .resetApp:
                confirmReset()
                break
            
            default:
                break
            }
            break
        case .productProgress:
            router?.routeToBoosProfileIsActive()
            break
        default:
            break
        }
        
    }
    
    
}
