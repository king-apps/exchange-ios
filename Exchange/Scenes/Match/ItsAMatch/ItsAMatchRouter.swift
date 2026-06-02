//
//  ItsAMatchRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 9/18/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ItsAMatchRoutingLogic {
    
}


protocol ItsAMatchDataPassing {
    var dataStore: ItsAMatchDataStore? { get }
}


class ItsAMatchRouter: NSObject, ItsAMatchRoutingLogic, ItsAMatchDataPassing {
    
    
    // Var's
    weak var viewController: ItsAMatchViewController?
    var dataStore: ItsAMatchDataStore?
  
    
}
