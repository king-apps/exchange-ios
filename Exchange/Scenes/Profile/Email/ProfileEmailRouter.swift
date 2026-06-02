//
//  ProfileEmailRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ProfileEmailRoutingLogic {
    func routeToToken(segue: UIStoryboardSegue?)
}


protocol ProfileEmailDataPassing {
    var dataStore: ProfileEmailDataStore? { get }
}


class ProfileEmailRouter: NSObject, ProfileEmailRoutingLogic, ProfileEmailDataPassing {
    
    
    // Var's
    weak var viewController: ProfileEmailViewController?
    var dataStore: ProfileEmailDataStore?
  
    
    // Routing
    func routeToToken(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ProfileEmailTokenViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToToken(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToToken(destination: inout ProfileEmailTokenDataStore) {
        destination.email = dataStore?.email
    }
    
    
}
