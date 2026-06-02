//
//  AuthNotificationRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthNotificationRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol AuthNotificationDataPassing {
    var dataStore: AuthNotificationDataStore? { get }
}


class AuthNotificationRouter: NSObject, AuthNotificationRoutingLogic, AuthNotificationDataPassing {
    
    
    // Var's
    weak var viewController: AuthNotificationViewController?
    var dataStore: AuthNotificationDataStore?
  
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue {
            if let destinationVC = segue.destination as? AuthTrackingViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToNext(source: dataStore!, destination: &destinationDS)
            }
        }
    }
    
    
    // Passing data
    func passDataToNext(source: AuthNotificationDataStore, destination: inout AuthTrackingDataStore) {
        destination.localConfig = source.localConfig
    }
    
    
}
