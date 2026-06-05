//
//  StickerScanResultPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerScanResultPresentationLogic {
    func load(response: StickerScanResult.Load.Response)
    func fetch(response: StickerScanResult.Fetch.Response)
    func save(response: StickerScanResult.Save.Response)
}


class StickerScanResultPresenter: StickerScanResultPresentationLogic {
  
    
    // Var's
    weak var viewController: StickerScanResultDisplayLogic?
  
    
    // Handler load
    func load(response: StickerScanResult.Load.Response) {
        
        let viewModel = StickerScanResult.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: StickerScanResult.Fetch.Response) {
        
        if let sticker = response.sticker {
            let item: StickerListCell.Item = .init(
                id: sticker.getId(),
                idProduct: sticker.getIdProduct(),
                title: sticker.getTitle(),
                description: sticker.getDescription(),
                collected: sticker.getCollected(),
                imageUrl: sticker.getImageUrl(),
                image: sticker.getImage()
            )
            
            let viewModel = StickerScanResult.Fetch.ViewModel(
                item: item,
                categoryUrl: response.category?.getLogo().isEmpty == false ? response.category?.getLogo() : nil,
                color: response.category?.getPrimaryColor() ?? AppTheme.Colors.brandPrimary500
            )
            viewController?.onFetch(viewModel: viewModel)
        }
        
    }
    
    
    // Handler save
    func save(response: StickerScanResult.Save.Response) {
        let item: StickerListCell.Item?
        
        if let sticker = response.sticker {
            item = .init(
                id: sticker.getId(),
                idProduct: sticker.getIdProduct(),
                title: sticker.getTitle(),
                description: sticker.getDescription(),
                collected: sticker.getCollected(),
                imageUrl: sticker.getImageUrl(),
                image: sticker.getImage()
            )
        }
        else {
            item = nil
        }
        
        let viewModel = StickerScanResult.Save.ViewModel(
            item: item,
            error: response.error
        )
        viewController?.onSave(viewModel: viewModel)
    }
    
    
}
