//
//  KnowMorePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import StoreKit


protocol KnowMorePresentationLogic {
    func load(response: KnowMore.Load.Response)
    func fetch(response: KnowMore.Fetch.Response)
    func purchase(response: KnowMore.Purchase.Response)
}


class KnowMorePresenter: KnowMorePresentationLogic {
  
    
    // Var's
    weak var viewController: KnowMoreDisplayLogic?
  
    
    // Handler load
    func load(response: KnowMore.Load.Response) {
        
        let viewModel = KnowMore.Load.ViewModel(
            option: response.option,
            icon: response.icon,
            iconColor: response.iconColor,
            title: response.title,
            subtitle: response.subtitle,
            description: response.description,
            buttonTitle: response.buttonTitle,
            buttonIsEnabled: response.buttonIsEnabled
        )
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: KnowMore.Fetch.Response) {
        
        if let buttonTitle = response.buttonTitle {
            
            var buttonIsPurchase = false
            if let _ = response.storeProduct {
                buttonIsPurchase = true
            }
            
            let viewModel = KnowMore.Fetch.ViewModel(
                buttonTitle: buttonTitle,
                buttonIsPurchase: buttonIsPurchase
            )
            viewController?.onFetch(viewModel: viewModel)
        }
        
    }
    
    
    // Handler purchase
    func purchase(response: KnowMore.Purchase.Response) {
        
        if let error = response.error {
            viewController?.onPurchase(error: error)
        }
        else {
            let viewModel = KnowMore.Purchase.ViewModel()
            viewController?.onPurchase(viewModel: viewModel)
        }
        
    }
    
    
}
