//
//  MyProductListRouter.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 2/18/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol MyProductListRoutingLogic {
    func routeToDetail(segue: UIStoryboardSegue?)
}


protocol MyProductListDataPassing {
    var dataStore: MyProductListDataStore? { get }
}


class MyProductListRouter: NSObject, MyProductListRoutingLogic, MyProductListDataPassing {
    
    
    // Var's
    weak var viewController: MyProductListViewController?
    var dataStore: MyProductListDataStore?
  
    
    // Routing
    func routeToDetail(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? MyProductDetailViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToDetail(source: MyProductListDataStore, destination: inout MyProductDetailDataStore) {
        destination.product = source.product
    }
    
    
}
