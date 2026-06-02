//
//  MyProductInputImageRouter.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 2/24/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol MyProductInputImageRoutingLogic {
    
}


protocol MyProductInputImageDataPassing {
    var dataStore: MyProductInputImageDataStore? { get }
}


class MyProductInputImageRouter: NSObject, MyProductInputImageRoutingLogic, MyProductInputImageDataPassing {
    
    
    // Var's
    weak var viewController: MyProductInputImageViewController?
    var dataStore: MyProductInputImageDataStore?
  
    
}
