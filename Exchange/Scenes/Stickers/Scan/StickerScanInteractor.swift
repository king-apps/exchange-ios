//
//  StickerScanInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerScanBusinessLogic {
    func load(request: StickerScan.Load.Request)
}


protocol StickerScanDataStore {
    
}


class StickerScanInteractor: StickerScanBusinessLogic, StickerScanDataStore {
    
    
    // Var's
    var presenter: StickerScanPresentationLogic?
    var worker = StickerScanWorker()
  
    
    // Handler load
    func load(request: StickerScan.Load.Request) {
        
        worker.load {
            let response = StickerScan.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
}
