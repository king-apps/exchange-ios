//
//  StickerListPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerListPresentationLogic {
    func load(response: StickerList.Load.Response)
    func fetch(response: StickerList.Fetch.Response)
    func updateCollected(response: StickerList.UpdateCollected.Response)
    func createProduct(response: StickerList.CreateProduct.Response)
    func save(response: StickerList.Save.Response)
    func product(response: StickerList.PProduct.Response)
}


class StickerListPresenter: StickerListPresentationLogic {
  
    
    // Var's
    weak var viewController: StickerListDisplayLogic?
  
    
    // Handler load
    func load(response: StickerList.Load.Response) {
        
        var rows = [MainTableRow]()
        rows.append(
            .loading(
                .init(height: response.height)
            )
        )
        
        let viewModel = StickerList.Load.ViewModel(
            keywords: response.keywords,
            rows: rows
        )
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: StickerList.Fetch.Response) {
    
        let viewModel = StickerList.Fetch.ViewModel(rows: makeRows(list: response.list))
        viewController?.onFetch(viewModel: viewModel)
        
    }
    
    
    // Handler update collected
    func updateCollected(response: StickerList.UpdateCollected.Response) {
        
        let viewModel = StickerList.UpdateCollected.ViewModel(
            id: response.id,
            rows: makeRows(list: response.list),
            error: response.error
        )
        viewController?.onUpdateCollected(viewModel: viewModel)
        
    }
    
    
    // Handler create product
    func createProduct(response: StickerList.CreateProduct.Response) {
        
        if let error = response.error {
            viewController?.onCreateProductError(error: error)
            return
        }
        
        let viewModel = StickerList.CreateProduct.ViewModel(rows: makeRows(list: response.list))
        viewController?.onCreateProduct(viewModel: viewModel)
        
    }
    
    
    // Rows
    private func makeRows(list: [StickerCategory]?) -> [MainTableRow] {
        
        var rows = [MainTableRow]()
        let stats = makeStats(list: list)
        
        
        if !LocalConfig.shared.filterStickerIsActive() {
            // Stats
            rows.append(
                .textCaptionSemibold(
                    .init(
                        color: .textOnSurface,
                        icon: .barChart,
                        title: "App.Statistics".localized.uppercased()
                    )
                )
            )
            rows.append(
                .productProgress(
                    .init(
                        id: 0,
                        iconLeft: .checkCircle,
                        image: nil,
                        title: "Sticker.List.Collected".localized,
                        progress: stats.collectedProgress,
                        description: "\(stats.collected)/\(stats.total)",
                        iconRight: .none,
                        color: .iconOnSurface,
                        identifier: .collected
                    )
                )
            )
            rows.append(
                .productProgress(
                    .init(
                        id: 0,
                        iconLeft: .plus,
                        image: nil,
                        title: "Sticker.List.Duplicated".localized,
                        progress: stats.duplicatedProgress,
                        description: "\(stats.duplicated)/\(stats.owned)",
                        iconRight: .none,
                        color: .iconOnSurface,
                        identifier: .duplicated
                    )
                )
            )
        }
        
        
        // Categories
        if let list, list.count > 0 {
            for stickerCategory in list {
                
                rows.append(.spacing(.init(size: .xl)))
                rows.append(
                    .stickerCategoryList(
                        .init(
                            iconLeft: stickerCategory.category.getLogo(),
                            name: stickerCategory.category.getCode(),
                            count: makeCategoryCount(stickerCategory),
                            color: stickerCategory.category.getPrimaryColor()
                        )
                    )
                )
            
                var itens = [StickerListCell.Item]()
                
                for sticker in stickerCategory.stickers {
                    itens.append(
                        .init(
                            id: sticker.getId(),
                            idProduct: sticker.getIdProduct(),
                            title: sticker.getTitle(),
                            description: sticker.getDescription(),
                            collected: sticker.getCollected(),
                            imageUrl: sticker.getImageUrl(),
                            image: sticker.getImage()
                        )
                    )
                    
                    if itens.count == 4 {
                        rows.append(
                            .stickerList(
                                .init(
                                    color: stickerCategory.category.getPrimaryColor(),
                                    items: itens
                                )
                            )
                        )
                        itens.removeAll()
                    }
                }
                
                // Se ainda sobrou item que nao foi adicionado, entao adiciona
                if itens.count > 0 {
                    rows.append(
                        .stickerList(
                            .init(
                                color: stickerCategory.category.getPrimaryColor(),
                                items: itens
                            )
                        )
                    )
                }
                
                
                
            }
        }
        else {
            rows.append(
                .empty(
                    .init(
                        icon: .bookOpen,
                        text: "Sticker.List.Empty.Filtered".localized
                    )
                )
            )
        }
        
        return rows
    }
    
    private func makeStats(list: [StickerCategory]?) -> (total: Int, collected: Int, duplicated: Int, owned: Int, collectedProgress: Float, duplicatedProgress: Float) {
        let stickers = list?.flatMap { $0.stickers } ?? []
        let total = stickers.count
        let collected = stickers.filter { $0.getCollected() > 0 }.count
        let duplicated = stickers.reduce(0) { $0 + max($1.getCollected() - 1, 0) }
        let owned = stickers.reduce(0) { $0 + $1.getCollected() }
        
        guard total > 0 else {
            return (0, 0, 0, 0, 0, 0)
        }
        
        return (
            total,
            collected,
            duplicated,
            owned,
            Float(collected) / Float(total),
            owned > 0 ? min(Float(duplicated) / Float(owned), 1) : 0
        )
    }
    
    private func makeCategoryCount(_ stickerCategory: StickerCategory) -> String {
        let total = stickerCategory.stickers.count
        let collected = stickerCategory.stickers.filter { $0.getCollected() > 0 }.count
        
        return "\(collected)/\(total)"
    }
    
    
    // Handler save
    func save(response: StickerList.Save.Response) {
        
        let viewModel = StickerList.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
    // Handler product
    func product(response: StickerList.PProduct.Response) {
        
        if let _ = response.product {
            let viewModel = StickerList.PProduct.ViewModel()
            viewController?.onProduct(viewModel: viewModel)
        }
        else {
            
        }
            
    }
    
    
}
