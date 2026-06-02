//
//  ProfileNameRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ProfileNameRoutingLogic {
    
}


protocol ProfileNameDataPassing {
    var dataStore: ProfileNameDataStore? { get }
}


class ProfileNameRouter: NSObject, ProfileNameRoutingLogic, ProfileNameDataPassing {
    
    
    // Var's
    weak var viewController: ProfileNameViewController?
    var dataStore: ProfileNameDataStore?
  
    
}
