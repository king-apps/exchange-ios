//
//  IntroRouter.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol IntroRoutingLogic {
    func routeToAuth()
    func routeToRoot()
    func routeToWelcome()
}


protocol IntroDataPassing {
    var dataStore: IntroDataStore? { get }
}


class IntroRouter: NSObject, IntroRoutingLogic, IntroDataPassing {
    
    
    // Var's
    weak var viewController: IntroViewController?
    var dataStore: IntroDataStore?
  
    
    // Routing
    func routeToAuth() {
        if let destinationVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController() {
            navigateTo(source: viewController!, destination: destinationVC)
        }
    }
    func routeToRoot() {
        if let destinationVC = UIStoryboard(name: "Root", bundle: nil).instantiateInitialViewController() {
            navigateTo(source: viewController!, destination: destinationVC)
        }
    }
    func routeToWelcome() {
        if let destinationVC = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController() {
            navigateTo(source: viewController!, destination: destinationVC)
        }
    }
  
    
    // Navigation
    func navigateTo(source: IntroViewController, destination: UIViewController) {
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
