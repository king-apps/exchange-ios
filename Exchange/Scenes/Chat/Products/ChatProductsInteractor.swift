//
//  ChatProductsInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatProductsBusinessLogic {
    func load(request: ChatProducts.Load.Request)
    func fetch(request: ChatProducts.Fetch.Request)
    func product(request: ChatProducts.Product.Request)
}


protocol ChatProductsDataStore {
    var chat: Chat? { get set }
    var product: Product? { get }
}


class ChatProductsInteractor: ChatProductsBusinessLogic, ChatProductsDataStore {
    
    
    // Var's
    var presenter: ChatProductsPresentationLogic?
    var worker = ChatProductsWorker()
  
    var chat: Chat?
    var chatProducts: [ChatProduct]?
    var product: Product?
    
    
    // Handler load
    func load(request: ChatProducts.Load.Request) {
        
        worker.load {
            let response = ChatProducts.Load.Response(height: request.height)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: ChatProducts.Fetch.Request) {
        
        worker.fetch(chat: self.chat) { chatProducts, error in
            
            // Store in memory
            self.chatProducts = chatProducts
            
            let response = ChatProducts.Fetch.Response(chatProducts: chatProducts, error: error)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler product
    func product(request: ChatProducts.Product.Request) {
        
        worker.product(productId: request.productId, chatProducts: self.chatProducts) { product in
            
            // Store in memory
            self.product = product
            
            let response = ChatProducts.Product.Response()
            self.presenter?.product(response: response)
        }
        
    }
    
    
}
