//
//  ProductDetailRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ProductDetailRoutingLogic {
    
}


protocol ProductDetailDataPassing {
    var dataStore: ProductDetailDataStore? { get }
}


class ProductDetailRouter: NSObject, ProductDetailRoutingLogic, ProductDetailDataPassing {
    
    
    // Var's
    weak var viewController: ProductDetailViewController?
    var dataStore: ProductDetailDataStore?
  
    
}
