//
//  PaywallV1Models.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import KingOS
import StoreKit


enum PaywallV1 {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }

    
    
    enum AB {
        struct Request {
            
        }
        struct Response {
            var abAssignment: KingOSABAssignment?
        }
        struct ViewModel {
            var abAssignment: KingOSABAssignment?
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var products: [SKProduct]
            var catalog: KingOSIAPCatalog?
            var abAssignment: KingOSABAssignment?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
            var productsByIdentifier: [String: SKProduct]
            var productIdentifierByRow: [Int: String]
            var selectedProductIdentifier: String?
            var offerKeyByIdentifier: [String: KingOSIAPOfferKey]
        }
    }
    
    
    enum Purchase {
        struct Request {
            var productIdentifier: String?
        }
        struct Response {
            var success: Bool
            var error: String?
        }
        struct ViewModel {
            var title: String
            var message: String
            var shouldDismiss: Bool
        }
    }
    
    
    enum Restore {
        struct Request {
            
        }
        struct Response {
            var restoredProducts: [InAppPurchase.Product]
            var error: String?
        }
        struct ViewModel {
            var title: String
            var message: String
            var shouldDismiss: Bool
        }
    }
    
}
