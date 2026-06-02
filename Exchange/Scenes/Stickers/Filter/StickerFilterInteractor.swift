//
//  StickerFilterInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerFilterBusinessLogic {
    func load(request: StickerFilter.Load.Request)
    func fetch(request: StickerFilter.Fetch.Request)
    func save(request: StickerFilter.Save.Request)
}


protocol StickerFilterDataStore {
    
}


class StickerFilterInteractor: StickerFilterBusinessLogic, StickerFilterDataStore {
    
    
    // Var's
    var presenter: StickerFilterPresentationLogic?
    var worker = StickerFilterWorker()
  
    
    // Handler load
    func load(request: StickerFilter.Load.Request) {
        
        worker.load {
            let response = StickerFilter.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: StickerFilter.Fetch.Request) {
        
        worker.fetch { config in
            let response = StickerFilter.Fetch.Response(config: config)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: StickerFilter.Save.Request) {
        
        worker.save(request: request) {
            let response = StickerFilter.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
