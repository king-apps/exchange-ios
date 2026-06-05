//
//  StickerScanPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerScanPresentationLogic {
    func load(response: StickerScan.Load.Response)
    func recognizeText(response: StickerScan.RecognizeText.Response)
}


class StickerScanPresenter: StickerScanPresentationLogic {
  
    
    // Var's
    weak var viewController: StickerScanDisplayLogic?
  
    
    // Handler load
    func load(response: StickerScan.Load.Response) {
        
        let viewModel = StickerScan.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    func recognizeText(response: StickerScan.RecognizeText.Response) {
        guard let code = response.code else { return }
        
        let viewModel = StickerScan.RecognizeText.ViewModel(
            code: code,
            sticker: response.sticker
        )
        viewController?.onRecognizeText(viewModel: viewModel)
    }
    
    
}
