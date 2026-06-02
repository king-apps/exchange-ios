//
//  AuthWelcomeRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 11/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthWelcomeRoutingLogic {
    
}


protocol AuthWelcomeDataPassing {
    var dataStore: AuthWelcomeDataStore? { get }
}


class AuthWelcomeRouter: NSObject, AuthWelcomeRoutingLogic, AuthWelcomeDataPassing {
    
    
    // Var's
    weak var viewController: AuthWelcomeViewController?
    var dataStore: AuthWelcomeDataStore?
  
    
}
