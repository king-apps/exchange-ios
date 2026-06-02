//
//  StickerCategoryListPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerCategoryListPresentationLogic {
    func load(response: StickerCategoryList.Load.Response)
    func fetch(response: StickerCategoryList.Fetch.Response)
    func save(response: StickerCategoryList.Save.Response)
    func clear(response: StickerCategoryList.Clear.Response)
}


class StickerCategoryListPresenter: StickerCategoryListPresentationLogic {
  
    
    // Var's
    weak var viewController: StickerCategoryListDisplayLogic?
  
    
    // Handler load
    func load(response: StickerCategoryList.Load.Response) {
        
        let viewModel = StickerCategoryList.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: StickerCategoryList.Fetch.Response) {
        
        let config = response.localConfig
        let rows = makeRows(config: config, categories: response.categories)
        let viewModel = StickerCategoryList.Fetch.ViewModel(rows: rows)
        viewController?.onFetch(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: StickerCategoryList.Save.Response) {
        
        let row = response.row
        let rows = makeRows(config: response.localConfig, categories: response.categories)
        let viewModel = StickerCategoryList.Save.ViewModel(
            row: row,
            rows: rows
        )
        viewController?.onSave(viewModel: viewModel)
    }
    
    
    // Handler clear
    func clear(response: StickerCategoryList.Clear.Response) {
        
        let config = response.localConfig
        let rows = makeRows(config: config, categories: response.categories)
        let viewModel = StickerCategoryList.Clear.ViewModel(rows: rows)
        viewController?.onClear(viewModel: viewModel)
        
    }

    
    // Make
    private func makeRows(config: LocalConfig, categories: [ProductCategory]?) -> [MainTableRow] {
        
        var rows = [MainTableRow]()
        let selectedCategoryIds = Set(config.getCategories())
        
        if let categories = categories {
            for category in categories {
                let isSelected = selectedCategoryIds.contains(category.getId())
                
                rows.append(
                    .default(
                        .init(
                            iconLeft: .none,
                            iconLeftUrl: category.getLogo(),
                            iconRight: isSelected ? .checkCircle : .circle,
                            iconRightUrl: nil,
                            title: category.getCode(),
                            titleNumberOfLines: nil,
                            description: category.getName(),
                            style: isSelected ? .selected : .normal,
                            identifier: .category,
                            tag: nil,
                            color: nil
                        )
                    )
                )
            }
        }
        
        return rows
        
    }
    
    
}
