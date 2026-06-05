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
    func recognizeText(request: StickerScan.RecognizeText.Request)
}


protocol StickerScanDataStore {
    var sticker: Sticker? { get }
}


class StickerScanInteractor: StickerScanBusinessLogic, StickerScanDataStore {
    
    
    // Var's
    var presenter: StickerScanPresentationLogic?
    var worker = StickerScanWorker()
    
    var sticker: Sticker?
  
    
    // Handler load
    func load(request: StickerScan.Load.Request) {
        
        worker.load {
            let response = StickerScan.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    func recognizeText(request: StickerScan.RecognizeText.Request) {
        let code = worker.recognize(texts: request.texts)
        let foundSticker = code.flatMap(worker.findSticker)
        
        if let foundSticker {
            sticker = foundSticker
        }
        
        let response = StickerScan.RecognizeText.Response(
            code: code,
            sticker: foundSticker
        )
        presenter?.recognizeText(response: response)
    }
    
    
}
