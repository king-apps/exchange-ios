//
//  StickerCategoryListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerCategoryListRoutingLogic {
    
}


protocol StickerCategoryListDataPassing {
    var dataStore: StickerCategoryListDataStore? { get }
}


class StickerCategoryListRouter: NSObject, StickerCategoryListRoutingLogic, StickerCategoryListDataPassing {
    
    
    // Var's
    weak var viewController: StickerCategoryListViewController?
    var dataStore: StickerCategoryListDataStore?
  
    
}
