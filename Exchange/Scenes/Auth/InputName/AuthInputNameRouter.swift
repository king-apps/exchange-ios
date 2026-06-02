//
//  AuthInputNameRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 13/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthInputNameRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol AuthInputNameDataPassing {
    var dataStore: AuthInputNameDataStore? { get }
}


class AuthInputNameRouter: NSObject, AuthInputNameRoutingLogic, AuthInputNameDataPassing {
    
    
    // Var's
    weak var viewController: AuthInputNameViewController?
    var dataStore: AuthInputNameDataStore?
    
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? AuthInputEmailViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToNext(destinationDS: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToNext(destinationDS: inout AuthInputEmailDataStore) {
        destinationDS.name = dataStore?.name
    }
  
    
}
