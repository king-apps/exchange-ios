//
//  MyProductDetailPresenter.swift
//  Troca Jogos
//
//  Created by Douglas Cicarello on 3/8/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol MyProductDetailPresentationLogic {
    func load(response: MyProductDetail.Load.Response)
    func save(response: MyProductDetail.Save.Response)
    func remove(response: MyProductDetail.Remove.Response)
}


class MyProductDetailPresenter: MyProductDetailPresentationLogic {
  
    
    // Var's
    weak var viewController: MyProductDetailDisplayLogic?
  
    
    // Handler load
    func load(response: MyProductDetail.Load.Response) {
        
        if let product = response.product {
            
            var images = [String]()
            
            for image in product.images {
                images.append(image.getUrl())
            }
            
            let viewModel = MyProductDetail.Load.ViewModel(
                name: product.getTitle(),
                category: product.category.getName(),
                categoryUrl: product.category.getLogo().isEmpty ? nil : product.category.getLogo(),
                conservation: product.conservation.getDescription(),
                description: product.getDescription(),
                images: images
            )
            viewController?.onLoad(viewModel: viewModel)
        }
        
        
    }
    
    
    // Handler save
    func save(response: MyProductDetail.Save.Response) {
    
        if let error = response.error {
            viewController?.onSaveError(error: error)
        }
        else {
            let viewModel = MyProductDetail.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    
    
    // Handler remove
    func remove(response: MyProductDetail.Remove.Response) {
        
        if let error = response.error {
            viewController?.onRemoveError(error: error)
        }
        else {
            let viewModel = MyProductDetail.Remove.ViewModel()
            viewController?.onRemove(viewModel: viewModel)
        }
        
    }
    
    
}
