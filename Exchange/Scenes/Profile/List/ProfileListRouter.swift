//
//  ProfileListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ProfileListRoutingLogic {
    func routeToTerms(segue: UIStoryboardSegue?)
    func routeToPrivacy(segue: UIStoryboardSegue?)
    
    func routeToDeleteAccount()
    func routeToBoosProfileIsActive()
}


protocol ProfileListDataPassing {
    var dataStore: ProfileListDataStore? { get }
}


class ProfileListRouter: NSObject, ProfileListRoutingLogic, ProfileListDataPassing {
    
    
    // Var's
    weak var viewController: ProfileListViewController?
    var dataStore: ProfileListDataStore?
  
    
    // Routing
    func routeToTerms(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? WebContentViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToTerms(destination: &destinationDS)
        }
    }
    func routeToPrivacy(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? WebContentViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToPrivacy(destination: &destinationDS)
        }
    }
    
    func routeToDeleteAccount() {
        routeToKnowMore(.deleteAccount)
    }
    func routeToBoosProfileIsActive() {
        routeToKnowMore(.boostProfileIsActive)
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
    func passDataToTerms(destination: inout WebContentDataStore) {
        destination.url = RemoteConfig.shared.getUrlTerms()
    }
    func passDataToPrivacy(destination: inout WebContentDataStore) {
        destination.url = RemoteConfig.shared.getUrlPrivacy()
    }
    
    func passDataToKnowMoreDeleteAccount(destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = .deleteAccount
    }
    
    private func passDataToKnowMore(_ option: KnowMoreOption, destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = option
    }
    
}
