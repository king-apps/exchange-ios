//
//  MatchFilterRouter.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/19/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol MatchFilterRoutingLogic {

}


protocol MatchFilterDataPassing {
    var dataStore: MatchFilterDataStore? { get }
}


class MatchFilterRouter: NSObject, MatchFilterRoutingLogic, MatchFilterDataPassing {
    
    
    // Var's
    weak var viewController: MatchFilterViewController?
    var dataStore: MatchFilterDataStore?

    
}
