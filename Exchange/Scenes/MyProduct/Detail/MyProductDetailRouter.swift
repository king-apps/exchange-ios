//
//  MyProductDetailRouter.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/8/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol MyProductDetailRoutingLogic {
    
}


protocol MyProductDetailDataPassing {
    var dataStore: MyProductDetailDataStore? { get }
}


class MyProductDetailRouter: NSObject, MyProductDetailRoutingLogic, MyProductDetailDataPassing {
    
    
    // Var's
    weak var viewController: MyProductDetailViewController?
    var dataStore: MyProductDetailDataStore?
  
    
}
