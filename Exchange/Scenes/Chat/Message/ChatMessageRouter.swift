//
//  ChatMessageRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 15/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ChatMessageRoutingLogic {
    func routeToProducts(segue: UIStoryboardSegue?)
    func routeToDenunciate()
    func routeToDenunciateSuccess()
}


protocol ChatMessageDataPassing {
    var dataStore: ChatMessageDataStore? { get }
}


class ChatMessageRouter: NSObject, ChatMessageRoutingLogic, ChatMessageDataPassing {
    
    
    // Var's
    weak var viewController: ChatMessageViewController?
    var dataStore: ChatMessageDataStore?
  
    
    // Routing
    func routeToProducts(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ChatProductsViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToProducts(destination: &destinationDS)
        }
    }
    func routeToDenunciate() {
        routeToKnowMore(.denunciate)
    }
    func routeToDenunciateSuccess() {
        routeToKnowMore(.denunciateSuccess)
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
    
    
    // Passing data
    func passDataToProducts(destination: inout ChatProductsDataStore) {
        destination.chat = dataStore?.chat
    }
    private func passDataToKnowMore(_ option: KnowMoreOption, destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = option
    }
    
}
