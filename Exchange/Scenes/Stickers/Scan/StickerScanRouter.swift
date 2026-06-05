//
//  StickerScanRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerScanRoutingLogic {
    
}


protocol StickerScanDataPassing {
    var dataStore: StickerScanDataStore? { get }
}


class StickerScanRouter: NSObject, StickerScanRoutingLogic, StickerScanDataPassing {
    
    
    // Var's
    weak var viewController: StickerScanViewController?
    var dataStore: StickerScanDataStore?
  
    
}
