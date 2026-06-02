//
//  ProfileEmailTokenRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ProfileEmailTokenRoutingLogic {
    
}


protocol ProfileEmailTokenDataPassing {
    var dataStore: ProfileEmailTokenDataStore? { get }
}


class ProfileEmailTokenRouter: NSObject, ProfileEmailTokenRoutingLogic, ProfileEmailTokenDataPassing {
    
    
    // Var's
    weak var viewController: ProfileEmailTokenViewController?
    var dataStore: ProfileEmailTokenDataStore?
  
    
}
