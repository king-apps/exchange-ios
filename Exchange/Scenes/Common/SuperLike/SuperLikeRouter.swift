//
//  SuperLikeRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 20/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol SuperLikeRoutingLogic {
    func routeToKnowMore(segue: UIStoryboardSegue?)
}


protocol SuperLikeDataPassing {
    var dataStore: SuperLikeDataStore? { get }
}


class SuperLikeRouter: NSObject, SuperLikeRoutingLogic, SuperLikeDataPassing {
    
    
    // Var's
    weak var viewController: SuperLikeViewController?
    var dataStore: SuperLikeDataStore?
  
    
    // Routing
    func routeToKnowMore(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? KnowMoreViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    let detent = UISheetPresentationController.Detent.custom(
                        identifier: .init("KnowMoreContent")
                    ) { [weak destinationVC] context in
                        destinationVC?.preferredSheetHeight(maximumHeight: context.maximumDetentValue)
                    }
                    sheet.detents = [detent]
                    destinationVC.sheetHeightDidChange = { [weak sheet] in
                        sheet?.invalidateDetents()
                    }
                }
                else {
                    sheet.detents = [.medium()]
                }
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            destinationVC.delegate = viewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToKnowMore(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToKnowMore(destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = .superLike
    }
    
    
}
