//
//  PaywallV1Interactor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol PaywallV1BusinessLogic {
    func load(request: PaywallV1.Load.Request)
    func AB(request: PaywallV1.AB.Request)
    func fetch(request: PaywallV1.Fetch.Request)
    func purchase(request: PaywallV1.Purchase.Request)
    func restore(request: PaywallV1.Restore.Request)
}


protocol PaywallV1DataStore {
    
}


class PaywallV1Interactor: PaywallV1BusinessLogic, PaywallV1DataStore {
    
    
    // Var's
    var presenter: PaywallV1PresentationLogic?
    var worker = PaywallV1Worker()
  
    
    // Handler load
    func load(request: PaywallV1.Load.Request) {
        
        worker.load {
            DispatchQueue.main.async {
                let response = PaywallV1.Load.Response()
                self.presenter?.load(response: response)
            }
        }
        
    }
    
    
    // Handler AB
    func AB(request: PaywallV1.AB.Request) {
    
        worker.AB { abAssignment in
            DispatchQueue.main.async {
                let response = PaywallV1.AB.Response(abAssignment: abAssignment)
                self.presenter?.AB(response: response)
            }
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: PaywallV1.Fetch.Request) {
        worker.fetch { products, catalog, abAssignment, error in
            DispatchQueue.main.async {
                let response = PaywallV1.Fetch.Response(
                    products: products ?? [],
                    catalog: catalog,
                    abAssignment: abAssignment,
                    error: error
                )
                self.presenter?.fetch(response: response)
            }
        }
        
    }
    
    func purchase(request: PaywallV1.Purchase.Request) {
        worker.purchase(productIdentifier: request.productIdentifier) { success, error in
            DispatchQueue.main.async {
                let response = PaywallV1.Purchase.Response(success: success, error: error)
                self.presenter?.purchase(response: response)
            }
        }
    }
    
    func restore(request: PaywallV1.Restore.Request) {
        worker.restore { restoredProducts, error in
            DispatchQueue.main.async {
                let response = PaywallV1.Restore.Response(
                    restoredProducts: restoredProducts,
                    error: error
                )
                self.presenter?.restore(response: response)
            }
        }
    }
    
}
