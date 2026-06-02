//
//  MatchFilterTagListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 9/8/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol MatchFilterTagListRoutingLogic {
    
}


protocol MatchFilterTagListDataPassing {
    var dataStore: MatchFilterTagListDataStore? { get }
}


class MatchFilterTagListRouter: NSObject, MatchFilterTagListRoutingLogic, MatchFilterTagListDataPassing {
    
    
    // Var's
    weak var viewController: MatchFilterTagListViewController?
    var dataStore: MatchFilterTagListDataStore?
  
    
}
