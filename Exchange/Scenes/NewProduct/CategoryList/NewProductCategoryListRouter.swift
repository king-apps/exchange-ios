//
//  NewProductCategoryListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol NewProductCategoryListRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol NewProductCategoryListDataPassing {
    var dataStore: NewProductCategoryListDataStore? { get }
}


class NewProductCategoryListRouter: NSObject, NewProductCategoryListRoutingLogic, NewProductCategoryListDataPassing {
    
    
    // Var's
    weak var viewController: NewProductCategoryListViewController?
    var dataStore: NewProductCategoryListDataStore?
  
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? MyProductInputNameViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToNext(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToNext(destination: inout MyProductInputNameDataStore) {
        destination.product = dataStore?.product
    }
    
    
}
