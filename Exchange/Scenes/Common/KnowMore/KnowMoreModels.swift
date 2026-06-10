//
//  KnowMoreModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit


enum KnowMore {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var option: KnowMoreOption?
            var icon: AppTheme.Icon
            var iconColor: UIColor
            var title: String
            var subtitle: String
            var description: String
            var buttonTitle: String
            var buttonIsEnabled: Bool
        }
        struct ViewModel {
            var option: KnowMoreOption?
            var icon: AppTheme.Icon
            var iconColor: UIColor
            var title: String
            var subtitle: String
            var description: String
            var buttonTitle: String
            var buttonIsEnabled: Bool
        }
    }

    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var buttonTitle: String?
            var storeProduct: SKProduct?
        }
        struct ViewModel {
            var buttonTitle: String
            var buttonIsPurchase: Bool
            var buttonIsEnabled: Bool
        }
    }
    
    
    enum Purchase {
        struct Request {
            
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
}
