//
//  AuthLocationRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 12/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthLocationRoutingLogic {
    
}


protocol AuthLocationDataPassing {
    var dataStore: AuthLocationDataStore? { get }
}


class AuthLocationRouter: NSObject, AuthLocationRoutingLogic, AuthLocationDataPassing {
    
    
    // Var's
    weak var viewController: AuthLocationViewController?
    var dataStore: AuthLocationDataStore?
  
    
}
