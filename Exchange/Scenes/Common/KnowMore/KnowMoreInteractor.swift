//
//  KnowMoreInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import StoreKit


protocol KnowMoreBusinessLogic {
    func load(request: KnowMore.Load.Request)
    func fetch(request: KnowMore.Fetch.Request)
    func purchase(request: KnowMore.Purchase.Request)
}


protocol KnowMoreDataStore {
    var knowMoreOption: KnowMoreOption? { get set }
}


class KnowMoreInteractor: KnowMoreBusinessLogic, KnowMoreDataStore {
    
    
    // Var's
    var presenter: KnowMorePresentationLogic?
    var worker = KnowMoreWorker()
  
    var knowMoreOption: KnowMoreOption?
    private var storeProduct: SKProduct?
    
    
    // Handler load
    func load(request: KnowMore.Load.Request) {
        
        worker.load(option: self.knowMoreOption) { icon, iconColor, title, subtitle, description, buttonTitle, buttonIsEnabled in
            let response = KnowMore.Load.Response(
                option: self.knowMoreOption,
                icon: icon,
                iconColor: iconColor,
                title: title,
                subtitle: subtitle,
                description: description,
                buttonTitle: buttonTitle,
                buttonIsEnabled: buttonIsEnabled
            )
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: KnowMore.Fetch.Request) {
        
        worker.fetch(option: self.knowMoreOption) { buttonTitle, product in
            
            // Store in memory
            self.storeProduct = product
            
            let response = KnowMore.Fetch.Response(buttonTitle: buttonTitle, storeProduct: self.storeProduct)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler purchase
    func purchase(request: KnowMore.Purchase.Request) {
        
        guard let storeProduct = self.storeProduct else {
            let response = KnowMore.Purchase.Response(error: "Alert.Generic.Error".localized)
            presenter?.purchase(response: response)
            return
        }
        
        worker.purchase(product: storeProduct) { error in
            let response = KnowMore.Purchase.Response(error: error)
            self.presenter?.purchase(response: response)
        }
        
    }
    
}
