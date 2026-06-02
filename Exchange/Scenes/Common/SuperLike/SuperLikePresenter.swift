//
//  SuperLikePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 20/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol SuperLikePresentationLogic {
    func load(response: SuperLike.Load.Response)
    func fetch(response: SuperLike.Fetch.Response)
    func send(response: SuperLike.Send.Response)
}


class SuperLikePresenter: SuperLikePresentationLogic {
  
    
    // Var's
    weak var viewController: SuperLikeDisplayLogic?
  
    
    // Handler load
    func load(response: SuperLike.Load.Response) {
        
        if let product = response.product {
            
            var rows = [MainTableRow]()
            
            // Product
            rows.append(
                .product(
                    .init(
                        id: product.getId(),
                        image: product.images.first?.getUrl() ?? "",
                        name: product.getTitle(),
                        icon: .none
                    )
                )
            )
            
            
            // Input
            rows.append(.spacing(.init(size: .lg)))
            rows.append(
                .inputTextView(
                    .init(
                        title: "SuperLike.Input.Title".localized,
                        placeholder: "SuperLike.Input.Placeholder".localized,
                        value: "SuperLike.Input.Value".localized,
                        error: "",
                        type: .Default,
                        identifier: .SuperLike,
                        isRequired: true,
                        maxLength: RemoteConfig.shared.getSuperLikeMaxLength(),
                        args: nil
                    )
                )
            )
            
            // Description
            rows.append(
                .textCaption(
                    .init(
                        text: "SuperLike.Input.Description".localized
                    )
                )
            )
            
            let viewModel = SuperLike.Load.ViewModel(rows: rows)
            viewController?.onLoad(viewModel: viewModel)
        }
    
        
    }
    
    
    // Handler fetch
    func fetch(response: SuperLike.Fetch.Response) {
        let title = "SuperLike.Purchase".localized.replacingOccurrences(of: "{$0}", with: response.price ?? "--")
        let viewModel = SuperLike.Fetch.ViewModel(title: title, isEnabled: response.price != nil)
        viewController?.onFetch(viewModel: viewModel)
    }
    
    
    // Handler send
    func send(response: SuperLike.Send.Response) {
        
        if let error = response.error {
            viewController?.onSend(error: error)
        }
        else {
            let viewModel = SuperLike.Send.ViewModel()
            viewController?.onSend(viewModel: viewModel)
        }
        
    }
    
    
}
