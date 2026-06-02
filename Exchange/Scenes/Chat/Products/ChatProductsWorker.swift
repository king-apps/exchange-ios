//
//  ChatProductsWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ChatProductsWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(chat: Chat?, completion: @escaping(_ chatProducts: [ChatProduct]?, _ error: String?) -> ()) {
        
        let api = MatchApi()
        let id = chat?.getId() ?? 0
        api.chatProducts(id: id) { chatProducts, error in
            completion(chatProducts, error)
        }
        
    }
    
    
    // Handler products
    func product(productId: Int, chatProducts: [ChatProduct]?, completion: @escaping(_ product: Product?) -> ()) {
        
        if let chatProducts = chatProducts {
            let chatProduct = chatProducts.first(where: {$0.product.getId() == productId})
            completion(chatProduct?.product)
        }
        
    }
    
}
