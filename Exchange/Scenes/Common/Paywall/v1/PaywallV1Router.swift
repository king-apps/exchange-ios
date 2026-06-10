//
//  PaywallV1Router.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol PaywallV1RoutingLogic {
    func routeToTermsOfUse(segue: UIStoryboardSegue?)
    func routeToPrivacyPolicy(segue: UIStoryboardSegue?)
}


protocol PaywallV1DataPassing {
    var dataStore: PaywallV1DataStore? { get }
}


class PaywallV1Router: NSObject, PaywallV1RoutingLogic, PaywallV1DataPassing {
    
    
    // Var's
    weak var viewController: PaywallV1ViewController?
    var dataStore: PaywallV1DataStore?
  
    
    // Routing
    func routeToTermsOfUse(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? WebContentViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToTermsOfUse(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func routeToPrivacyPolicy(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? WebContentViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = AppTheme.Radius.lg
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToPrivacyPolicy(source: dataStore!, destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToTermsOfUse(source: PaywallV1DataStore, destination: inout WebContentDataStore) {
        destination.url = RemoteConfig.shared.getUrlTerms()
    }
    
    func passDataToPrivacyPolicy(source: PaywallV1DataStore, destination: inout WebContentDataStore) {
        destination.url = RemoteConfig.shared.getUrlPrivacy()
    }
    
}
