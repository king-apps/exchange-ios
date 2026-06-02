//
//  AuthMainRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 26/11/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol AuthMainRoutingLogic {
    
}


protocol AuthMainDataPassing {
    var dataStore: AuthMainDataStore? { get }
}


class AuthMainRouter: NSObject, AuthMainRoutingLogic, AuthMainDataPassing {
    
    
    // Var's
    weak var viewController: AuthMainViewController?
    var dataStore: AuthMainDataStore?
  
    
}
