//
//  ChatProductsRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ChatProductsRoutingLogic {
    func routeToProduct(segue: UIStoryboardSegue?)
}


protocol ChatProductsDataPassing {
    var dataStore: ChatProductsDataStore? { get }
}


class ChatProductsRouter: NSObject, ChatProductsRoutingLogic, ChatProductsDataPassing {
    
    
    // Var's
    weak var viewController: ChatProductsViewController?
    var dataStore: ChatProductsDataStore?
  
    
    // Routing
    func routeToProduct(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ProductDetailViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24 // AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToProduct(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToProduct(destination: inout ProductDetailDataStore) {
        destination.product = dataStore?.product
    }
    
}
