//
//  PaywallV1Worker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import KingOS
import StoreKit


class PaywallV1Worker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler AB
    func AB(completion: @escaping(_ abAssignment: KingOSABAssignment?) -> ()) {
        
        Task {
            if let abAssignment = await KingOS.shared.ab.request(experimentKey: KingOSExperiment.paywall.rawValue) {
                KingOS.shared.ab.impression(experimentKey: KingOSExperiment.paywall.rawValue)
                completion(abAssignment)
            }
            else {
                completion(nil)
            }
        }
        
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ products: [SKProduct]?, _ catalog: KingOSIAPCatalog?, _ abAssignment: KingOSABAssignment?, _ error: String?) -> ()) {
        Task {
            let catalog = await KingOS.shared.iap.request()
            let productIdentifiers = catalog?.offers.map(\.storeProductId) ?? []
            InAppPurchase.shared.configureIdentifiers(from: catalog)
            
            InAppPurchase.shared.request(productIdentifiers: productIdentifiers) { products, error in
                Task {
                    if let abAssignment = await KingOS.shared.ab.request(experimentKey: KingOSExperiment.paywall.rawValue) {
                        completion(products, catalog, abAssignment, error)
                    }
                    else {
                        completion(products, catalog, nil, error)
                    }
                }
            }
        }
    }
    
    func purchase(productIdentifier: String?, completion: @escaping(_ success: Bool, _ error: String?) -> ()) {
        guard let productIdentifier, !productIdentifier.isEmpty else {
            completion(false, "PayWall.Purchase.ProductRequired".localized)
            return
        }
        
        InAppPurchase.shared.request(productIdentifiers: [productIdentifier]) { products, error in
            guard let storeProduct = products?.first(where: { $0.productIdentifier == productIdentifier }) else {
                completion(false, error ?? InAppPurchase.InAppPurchaseError.productNotFound.localizedDescription)
                return
            }
            
            InAppPurchase.shared.purchase(product: storeProduct) { result in
                switch result {
                case .success:
                    KingOS.shared.iap.conversion(product: storeProduct)
                    KingOS.shared.ab.conversion(
                        experimentKey: KingOSExperiment.paywall.rawValue,
                        value: storeProduct.price.doubleValue,
                        currency: storeProduct.priceLocale.currency?.identifier ?? "BRL"
                    )
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func restore(completion: @escaping(_ restoredProducts: [InAppPurchase.Product], _ error: String?) -> ()) {
        InAppPurchase.shared.restore { result in
            switch result {
            case .success(let restoredProducts):
                if restoredProducts.isEmpty {
                    completion([], "PayWall.Restore.Empty.Message".localized)
                }
                else {
                    completion(restoredProducts, nil)
                }
            case .failure(let error):
                completion([], error.localizedDescription)
            }
        }
    }
    
}
