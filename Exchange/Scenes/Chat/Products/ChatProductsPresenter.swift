//
//  ChatProductsPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 16/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatProductsPresentationLogic {
    func load(response: ChatProducts.Load.Response)
    func fetch(response: ChatProducts.Fetch.Response)
    func product(response: ChatProducts.Product.Response)
}


class ChatProductsPresenter: ChatProductsPresentationLogic {
  
    
    // Var's
    weak var viewController: ChatProductsDisplayLogic?
  
    
    // Handler load
    func load(response: ChatProducts.Load.Response) {
        
        let height = response.height
        let rows: [MainTableRow] = [
            .loading(
                .init(height: height)
            )
        ]
        
        let viewModel = ChatProducts.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: ChatProducts.Fetch.Response) {
        
        if let chatProducts = response.chatProducts {
            var rows: [MainTableRow] = []
            
            let meId = User.shared.getId()
            let heProducts = chatProducts.filter({$0.user.getId() != meId})
            let heUser = chatProducts.first(where :{$0.user.getId() != meId})
            let meProducts = chatProducts.filter({$0.user.getId() == meId})
            
            // He
            if heProducts.count > 0 {
                
                var heName = "Chat.Products.He.Title.Unknow".localized.uppercased()
                if let heUser = heUser {
                    if !heUser.user.getName().isEmpty {
                        heName = "Chat.Products.He.Name".localized.replacingOccurrences(of: "{$0}", with: heUser.user.getName()).uppercased()
                    }
                }
                
                rows.append(
                    .textCaptionSemibold(
                        .init(
                            color: .textOnSurfaceSecondary,
                            icon: .none,
                            title: heName
                        )
                    )
                )
                for chatProduct in heProducts {
                    
                    rows.append(
                        .product(
                            .init(
                                id: chatProduct.product.getId(),
                                image: chatProduct.product.images.first?.getUrl() ?? "",
                                name: chatProduct.product.getTitle(),
                                icon: .arrowRight
                            )
                        )
                    )
                    
                }
            }
            
            
            // Me
            if meProducts.count > 0 {
                rows.append(
                    .textCaptionSemibold(
                        .init(
                            color: .textOnSurfaceSecondary,
                            icon: .none,
                            title: "SEUS PRODUTOS"
                        )
                    )
                )
                for chatProduct in meProducts {
                    
                    rows.append(
                        .product(
                            .init(
                                id: chatProduct.product.getId(),
                                image: chatProduct.product.images.first?.getUrl() ?? "",
                                name: chatProduct.product.getTitle(),
                                icon: .arrowRight
                            )
                        )
                    )
                    
                }
            }
            
            let viewModel = ChatProducts.Fetch.ViewModel(rows: rows)
            viewController?.onFetch(viewModel: viewModel)
        }
        else {
            
        }
        
    }
    
    
    // Handler product
    func product(response: ChatProducts.Product.Response) {
     
        let viewModel = ChatProducts.Product.ViewModel()
        viewController?.onProduct(viewModel: viewModel)
        
    }
    
}
