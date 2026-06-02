//
//  StickerCategoryListInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerCategoryListBusinessLogic {
    func load(request: StickerCategoryList.Load.Request)
    func fetch(request: StickerCategoryList.Fetch.Request)
    func save(request: StickerCategoryList.Save.Request)
    func clear(request: StickerCategoryList.Clear.Request)
}


protocol StickerCategoryListDataStore {
    
}


class StickerCategoryListInteractor: StickerCategoryListBusinessLogic, StickerCategoryListDataStore {
    
    
    // Var's
    var presenter: StickerCategoryListPresentationLogic?
    var worker = StickerCategoryListWorker()
    
    var categories: [ProductCategory]?
  
    
    // Handler load
    func load(request: StickerCategoryList.Load.Request) {
        
        worker.load {
            let response = StickerCategoryList.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: StickerCategoryList.Fetch.Request) {
        
        worker.fetch { categories, localConfig in
            
            // Store in memory
            self.categories = categories
            
            let response = StickerCategoryList.Fetch.Response(
                categories: categories,
                localConfig: localConfig
            )
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: StickerCategoryList.Save.Request) {
        
        worker.save(row: request.row, categories: self.categories) { config in
            let response = StickerCategoryList.Save.Response(
                row: request.row,
                categories: self.categories,
                localConfig: config
            )
            self.presenter?.save(response: response)
        }
        
    }
    
    
    // Handler clear
    func clear(request: StickerCategoryList.Clear.Request) {
        
        worker.clear { localConfig in
            let response = StickerCategoryList.Clear.Response(
                categories: self.categories,
                localConfig: localConfig
            )
            self.presenter?.clear(response: response)
        }
        
    }
    
    
}
