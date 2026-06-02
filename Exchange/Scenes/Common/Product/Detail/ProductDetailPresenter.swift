//
//  ProductDetailPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProductDetailPresentationLogic {
    func load(response: ProductDetail.Load.Response)
    func fetch(response: ProductDetail.Fetch.Response)
}


class ProductDetailPresenter: ProductDetailPresentationLogic {
  
    
    // Var's
    weak var viewController: ProductDetailDisplayLogic?
  
    
    // Handler load
    func load(response: ProductDetail.Load.Response) {
        
        let viewModel = ProductDetail.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: ProductDetail.Fetch.Response) {
        
        if let product = response.product {
            
            var images: [String] = []
            for image in product.images {
                images.append(image.getUrl())
            }
            
            var distance = ""
            if product.getDistance() > 0 {
                distance = "\(product.getDistance()) "+"App.Radius.Code".localized
            }
            
            let viewModel = ProductDetail.Fetch.ViewModel(
                images: images,
                name: product.getTitle(),
                distance: distance,
                category: product.category.getName(),
                categoryImage: product.category.getLogo(),
                conservation: product.conservation.getDescription(),
                description: product.getDescription()
            )
            viewController?.onFetch(viewModel: viewModel)
        }
        
    }
    
    
}
