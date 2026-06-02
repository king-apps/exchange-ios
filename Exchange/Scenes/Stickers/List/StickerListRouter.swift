//
//  StickerListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol StickerListRoutingLogic {
    func routeToStickerImage()
    func routeToFilter(segue: UIStoryboardSegue?)
    func routeToStickerInfo()
    func routeToProduct(segue: UIStoryboardSegue?)
}


protocol StickerListDataPassing {
    var dataStore: StickerListDataStore? { get }
}


class StickerListRouter: NSObject, StickerListRoutingLogic, StickerListDataPassing {
    
    
    // Var's
    weak var viewController: StickerListViewController?
    var dataStore: StickerListDataStore?
    
    
    // Routing
    func routeToStickerImage() {
        routeToKnowMore(.stickerImage)
    }
    func routeToStickerInfo() {
        routeToKnowMore(.stickerInfo)
    }
    private func routeToKnowMore(_ option: KnowMoreOption) {
        if let destinationVC = UIStoryboard(name: "KnowMore", bundle: nil).instantiateInitialViewController() as? KnowMoreViewController {
            destinationVC.modalPresentationStyle = .pageSheet
            
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
            passDataToKnowMore(option, destination: &destinationDS)
            
            viewController?.present(destinationVC, animated: true)
        }
    }
    func routeToFilter(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? StickerFilterViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            destinationVC.delegate = viewController
        }
    }
    func routeToProduct(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ProductDetailViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToProduct(source: dataStore!, destination: &destinationDS)
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
        }
    }
    
    
    // Passing data
    private func passDataToKnowMore(_ option: KnowMoreOption, destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = option
    }
    func passDataToProduct(source: StickerListDataStore, destination: inout ProductDetailDataStore) {
        destination.product = source.product
    }
  
    
}
