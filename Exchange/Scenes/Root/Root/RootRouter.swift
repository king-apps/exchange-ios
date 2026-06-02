//
//  RootRouter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol RootRoutingLogic {
    
}


protocol RootDataPassing {
    var dataStore: RootDataStore? { get }
}


class RootRouter: NSObject, RootRoutingLogic, RootDataPassing {
    
    
    // Var's
    weak var viewController: RootViewController?
    var dataStore: RootDataStore?
  
    
}
