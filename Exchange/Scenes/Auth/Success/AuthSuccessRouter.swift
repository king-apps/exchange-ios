//
//  AuthSuccessRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 02/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthSuccessRoutingLogic {
    func routeToRoot()
}


protocol AuthSuccessDataPassing {
    var dataStore: AuthSuccessDataStore? { get }
}


class AuthSuccessRouter: NSObject, AuthSuccessRoutingLogic, AuthSuccessDataPassing {
    
    
    // Var's
    weak var viewController: AuthSuccessViewController?
    var dataStore: AuthSuccessDataStore?
  
    
    // Routing
    func routeToRoot() {
        if let destinationVC = UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController() {
            navigateTo(source: viewController!, destination: destinationVC)
        }
    }
  
    
    // Navigation
    func navigateTo(source: AuthSuccessViewController, destination: UIViewController) {
        DispatchQueue.main.async {
            guard
                let windowScene = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
            else { return }

            sceneDelegate.setRootViewController(destination)
        }
    }
    
    
}
