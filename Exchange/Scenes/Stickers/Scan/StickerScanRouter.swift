//
//  StickerScanRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerScanRoutingLogic {
    func routeToResult(segue: UIStoryboardSegue?)
}


protocol StickerScanDataPassing {
    var dataStore: StickerScanDataStore? { get }
}


class StickerScanRouter: NSObject, StickerScanRoutingLogic, StickerScanDataPassing {
    
    
    // Var's
    weak var viewController: StickerScanViewController?
    var dataStore: StickerScanDataStore?
  
    
    // Routing
    func routeToResult(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? StickerScanResultViewController {
            destinationVC.delegate = viewController
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToResult(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToResult(destination: inout StickerScanResultDataStore) {
        destination.sticker = dataStore?.sticker
    }
    
}
