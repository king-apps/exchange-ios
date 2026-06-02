//
//  StickerFilterRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerFilterRoutingLogic {
    
}


protocol StickerFilterDataPassing {
    var dataStore: StickerFilterDataStore? { get }
}


class StickerFilterRouter: NSObject, StickerFilterRoutingLogic, StickerFilterDataPassing {
    
    
    // Var's
    weak var viewController: StickerFilterViewController?
    var dataStore: StickerFilterDataStore?
  
    
}
