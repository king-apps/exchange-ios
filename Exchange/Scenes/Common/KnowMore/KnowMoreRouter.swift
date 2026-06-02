//
//  KnowMoreRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol KnowMoreRoutingLogic {
    
}


protocol KnowMoreDataPassing {
    var dataStore: KnowMoreDataStore? { get }
}


class KnowMoreRouter: NSObject, KnowMoreRoutingLogic, KnowMoreDataPassing {
    
    
    // Var's
    weak var viewController: KnowMoreViewController?
    var dataStore: KnowMoreDataStore?
  
    
}
