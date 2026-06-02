//
//  ChatListRouter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


@objc protocol ChatListRoutingLogic {
    func routeToChatMessage(segue: UIStoryboardSegue?)
}


protocol ChatListDataPassing {
    var dataStore: ChatListDataStore? { get }
}


class ChatListRouter: NSObject, ChatListRoutingLogic, ChatListDataPassing {
    
    
    // Var's
    weak var viewController: ChatListViewController?
    var dataStore: ChatListDataStore?
  
    
    // Routing
    func routeToChatMessage(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ChatMessageViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToChatMessage(destination: &destinationDS)
        }
    }
    
    
    // Passing data
    func passDataToChatMessage(destination: inout ChatMessageDataStore) {
        destination.chat = self.dataStore?.chat
    }
    
    
}
