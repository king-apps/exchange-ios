//
//  WebContentRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol WebContentRoutingLogic {
    
}


protocol WebContentDataPassing {
    var dataStore: WebContentDataStore? { get }
}


class WebContentRouter: NSObject, WebContentRoutingLogic, WebContentDataPassing {
    
    
    // Var's
    weak var viewController: WebContentViewController?
    var dataStore: WebContentDataStore?
  
    
}
