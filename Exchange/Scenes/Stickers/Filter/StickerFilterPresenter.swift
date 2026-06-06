//
//  StickerFilterPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol StickerFilterPresentationLogic {
    func load(response: StickerFilter.Load.Response)
    func fetch(response: StickerFilter.Fetch.Response)
    func save(response: StickerFilter.Save.Response)
}


class StickerFilterPresenter: StickerFilterPresentationLogic {
  
    
    // Var's
    weak var viewController: StickerFilterDisplayLogic?
  
    
    // Handler load
    func load(response: StickerFilter.Load.Response) {
        
        let viewModel = StickerFilter.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: StickerFilter.Fetch.Response) {
        
        var rows = [MainTableRow]()
        let config = response.config
        
        
        
        // Inputs
        /*
        rows.append(
            .inputSelect(
                .init(
                    title: "StickerFilter.Categories.Title".localized,
                    placeholder:
                    config.getCategories().count > 0
                    ? "StickerFilter.Categories.Value".localized.replacingOccurrences(of: "{$0}", with: "\(config.getCategories().count)")
                    : "StickerFilter.Categories.Placeholder".localized
                    ,
                    value: "",
                    count: "", // config.getCategories().count > 0 ? "\(config.getCategories().count)" : "",
                    iconLeft: config.getCategories().count > 0
                    ? .checkCircle
                    : .circle
                    ,
                    iconRight: .arrowRight,
                    isEnabled: true,
                    identifier: .category
                )
            )
        )
        */
        
        // Options
        /*
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "StickerFilter.Options.Title".localized
                )
            )
        )*/
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.SortByName".localized,
                    isOn: config.getStickerFilterSortByName(),
                    identifier: .sortByName
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.Locked".localized,
                    isOn: config.getStickerFilterLocked(),
                    identifier: .locked
                )
            )
        )
        rows.append(.spacing(.init(size: .lg)))
        
        
        // Only
        rows.append(
            .textCaptionSemibold(
                .init(
                    color: .textOnSurfaceSecondary,
                    icon: .none,
                    title: "StickerFilter.Only.Title".localized
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.OnlyCollected".localized,
                    isOn: config.getStickerFilterOnlyCollected(),
                    identifier: .collected
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.OnlyDuplicated".localized,
                    isOn: config.getStickerFilterOnlyDuplicated(),
                    identifier: .duplicated
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.OnlyMissing".localized,
                    isOn: config.getStickerFilterOnlyMissing(),
                    identifier: .missing
                )
            )
        )
        rows.append(
            .switch(
                .init(
                    title: "StickerFilter.OnlyPublished".localized,
                    isOn: config.getStickerFilterOnlyPublished(),
                    identifier: .published
                )
            )
        )
        
        let viewModel = StickerFilter.Fetch.ViewModel(rows: rows)
        viewController?.onFetch(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: StickerFilter.Save.Response) {
        
        let viewModel = StickerFilter.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
    }
    
    
    
}
