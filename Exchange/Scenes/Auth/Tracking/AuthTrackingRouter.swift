//
//  AuthTrackingRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthTrackingRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol AuthTrackingDataPassing {
    var dataStore: AuthTrackingDataStore? { get }
}


class AuthTrackingRouter: NSObject, AuthTrackingRoutingLogic, AuthTrackingDataPassing {
    
    
    // Var's
    weak var viewController: AuthTrackingViewController?
    var dataStore: AuthTrackingDataStore?
  
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue {
            if let destinationVC = segue.destination as? AuthInputEmailViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToNext(source: dataStore!, destination: &destinationDS)
            }
        }
    }
    
    
    // Passing data
    func passDataToNext(source: AuthTrackingDataStore, destination: inout AuthInputEmailDataStore) {
        
    }
    
}
