//
//  StickerScanResultInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerScanResultBusinessLogic {
    func load(request: StickerScanResult.Load.Request)
    func fetch(request: StickerScanResult.Fetch.Request)
    func save(request: StickerScanResult.Save.Request)
}


protocol StickerScanResultDataStore {
    var sticker: Sticker? { get set }
}


class StickerScanResultInteractor: StickerScanResultBusinessLogic, StickerScanResultDataStore {
    
    
    // Var's
    var presenter: StickerScanResultPresentationLogic?
    var worker = StickerScanResultWorker()
    
    var sticker: Sticker?
  
    
    // Handler load
    func load(request: StickerScanResult.Load.Request) {
        
        worker.load {
            let response = StickerScanResult.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: StickerScanResult.Fetch.Request) {
        
        worker.fetch {
            let response = StickerScanResult.Fetch.Response(
                sticker: self.sticker,
                category: self.worker.fetchCategory(id: self.sticker?.getIdCategory())
            )
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: StickerScanResult.Save.Request) {
        
        worker.save(sticker: self.sticker) { sticker, error in
            self.sticker = sticker
            
            let response = StickerScanResult.Save.Response(
                sticker: sticker,
                error: error
            )
            self.presenter?.save(response: response)
        }
    }
    
    
}
