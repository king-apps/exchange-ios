//
//  StickerScanResultRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerScanResultRoutingLogic {
    
}


protocol StickerScanResultDataPassing {
    var dataStore: StickerScanResultDataStore? { get }
}


class StickerScanResultRouter: NSObject, StickerScanResultRoutingLogic, StickerScanResultDataPassing {
    
    
    // Var's
    weak var viewController: StickerScanResultViewController?
    var dataStore: StickerScanResultDataStore?
  
    
}
