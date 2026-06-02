//
//  NewProductMainRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol NewProductMainRoutingLogic {
    
}


protocol NewProductMainDataPassing {
    var dataStore: NewProductMainDataStore? { get }
}


class NewProductMainRouter: NSObject, NewProductMainRoutingLogic, NewProductMainDataPassing {
    
    
    // Var's
    weak var viewController: NewProductMainViewController?
    var dataStore: NewProductMainDataStore?
  
    
}
