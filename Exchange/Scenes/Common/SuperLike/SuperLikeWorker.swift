//
//  SuperLikeWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 20/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import StoreKit
import UIKit
import KingOS


class SuperLikeWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ product: SKProduct?, _ price: String?) -> ()) {
        let productIdentifier = AppEnvironment.storeProductIdentifier(for: .superLike)
        
        InAppPurchase.shared.request(productIdentifiers: [productIdentifier]) { products, _ in
            let product = products?.first(where: { $0.productIdentifier == productIdentifier })
            let price = product?.localizedPrice
            
            DispatchQueue.main.async {
                completion(product, price)
            }
        }
        
    }
    
    
    // Handler save
    func save(product: Product?, storeProduct: SKProduct?, message: String, completion: @escaping(_ error: String?) -> ()) {
        
       
        guard let storeProduct else {
            completion("Alert.Generic.Error".localized)
            return
        }
       
        InAppPurchase.shared.purchaseConsumable(product: storeProduct) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    KingOS.shared.iap.conversion(product: storeProduct)
                    self.send(product: product, message: message, completion: completion)
                case .failure(let error):
                    completion(error.localizedDescription)
                }
            }
        }
    }
    
    
    // Handler send
    private func send(product: Product?, message: String, completion: @escaping(_ error: String?) -> ()) {
        
        let id = product?.getId() ?? 0
        let api = MatchApi()
        let request = MatchProductSuperLikeRequestDTO(id: id, message: message)
        api.productSuperLike(request: request) { error in
            completion(error)
        }
        
    }
    
    
}
