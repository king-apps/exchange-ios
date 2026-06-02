//
//  AuthInputTokenRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthInputTokenRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol AuthInputTokenDataPassing {
    var dataStore: AuthInputTokenDataStore? { get }
}


class AuthInputTokenRouter: NSObject, AuthInputTokenRoutingLogic, AuthInputTokenDataPassing {
    
    
    // Var's
    weak var viewController: AuthInputTokenViewController?
    var dataStore: AuthInputTokenDataStore?
  
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue {
            if let destinationVC = segue.destination as? AuthSuccessViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToNext(source: dataStore!, destination: &destinationDS)
            }
        }
    }

    
    // Passing data
    func passDataToNext(source: AuthInputTokenDataStore, destination: inout AuthSuccessDataStore) {
        destination.localConfig = source.localConfig
    }
    
    
}
