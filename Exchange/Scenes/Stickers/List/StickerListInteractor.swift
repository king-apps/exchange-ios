//
//  StickerListInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerListBusinessLogic {
    func load(request: StickerList.Load.Request)
    func fetch(request: StickerList.Fetch.Request)
    func updateCollected(request: StickerList.UpdateCollected.Request)
    func createProduct(request: StickerList.CreateProduct.Request)
    func save(request: StickerList.Save.Request)
    func product(request: StickerList.PProduct.Request)
}


protocol StickerListDataStore {
    var product: Product? { get }
}


class StickerListInteractor: StickerListBusinessLogic, StickerListDataStore {
    
    
    // Var's
    var presenter: StickerListPresentationLogic?
    var worker = StickerListWorker()
    
    var products: [Product]?
    var product: Product?
    var list: [StickerCategory]?
  
    
    // Handler load
    func load(request: StickerList.Load.Request) {
        
        worker.load { keywords in
            let response = StickerList.Load.Response(
                keywords: keywords,
                height: request.height
            )
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: StickerList.Fetch.Request) {
        
        worker.fetch { products, list, error, showAds in
            
            // Store in memory
            self.products = products
            self.list = list
            
            let response = StickerList.Fetch.Response(
                list: list,
                error: error,
                showAds: showAds
            )
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler update collected
    func updateCollected(request: StickerList.UpdateCollected.Request) {
        
        worker.updateCollected(id: request.id, operation: request.operation, list: list) { list, error in
            
            // Store in memory
            self.list = list
            
            let response = StickerList.UpdateCollected.Response(
                id: request.id,
                list: list,
                error: error,
                showAds: AppAdPolicy.shouldShowAds()
            )
            self.presenter?.updateCollected(response: response)
        }
        
    }
    
    
    // Handler create product
    func createProduct(request: StickerList.CreateProduct.Request) {
        
        worker.createProduct(id: request.id, image: request.image, list: list) { list, product, error in
            
            // Store in memory
            self.list = list
            
            if let product {
                if let index = self.products?.firstIndex(where: { $0.getId() == product.getId() }) {
                    self.products?[index] = product
                }
                else {
                    self.products = (self.products ?? []) + [product]
                }
            }
            
            let response = StickerList.CreateProduct.Response(
                list: list,
                product: product,
                error: error,
                showAds: AppAdPolicy.shouldShowAds()
            )
            self.presenter?.createProduct(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: StickerList.Save.Request) {
        
        worker.save(keywords: request.keywords) {
            let response = StickerList.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
    // Handler produtc
    func product(request: StickerList.PProduct.Request) {
        
        worker.product(id: request.id, products: self.products) { product in
            
            // Store in memory
            self.product = product
            
            let response = StickerList.PProduct.Response(product: product)
            self.presenter?.product(response: response)
        }
        
    }
    
    
}
