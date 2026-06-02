//
//  NewProductCategoryListPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductCategoryListPresentationLogic {
    func load(response: NewProductCategoryList.Load.Response)
    func search(response: NewProductCategoryList.Search.Response)
    func save(response: NewProductCategoryList.Save.Response)
}


class NewProductCategoryListPresenter: NewProductCategoryListPresentationLogic {
  
    
    // Var's
    weak var viewController: NewProductCategoryListDisplayLogic?
  
    
    // Handler load
    func load(response: NewProductCategoryList.Load.Response) {
        
        let rows: [MainTableRow] = [
            .loading(
                .init(height: response.height)
            )
        ]
        let viewModel = NewProductCategoryList.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler search
    func search(response: NewProductCategoryList.Search.Response) {
        
        if let error = response.error {
            viewController?.onSearch(error: error)
        }
        else {
            var rows = [MainTableRow]()
            
            if let categories = response.categories, categories.count > 0 {
                
                for category in categories {
                    rows.append(
                        .default(
                            .init(
                                iconLeft: .none,
                                iconLeftUrl: category.getLogo(),
                                iconRight: .arrowRight,
                                title: category.getName(),
                                titleNumberOfLines: nil,
                                description: category.getCode(),
                                style: .normal,
                                identifier: .generic,
                                color: category.getPrimaryColor()
                            )
                        )
                    )
                }
                
                
                /*
                 // Like KIMBA
                var index = 0
                var productCategoryLeft: ProductCategory?
                var productCategoryRight: ProductCategory?
                
                
                for category in categories {
                    
                    if index == 0 {
                        productCategoryLeft = category
                    }
                    if index == 1 {
                        productCategoryRight = category
                        index = 0
                    }
                    else {
                        index += 1
                    }
                    
                    if let left = productCategoryLeft, let right = productCategoryRight {
                        rows.append(
                            .productCategory(
                                .init(
                                    productCategoryLeft: left,
                                    productCategoryRight: right
                                )
                            )
                        )
                        productCategoryLeft = nil
                        productCategoryRight = nil
                    }
                   
                }
                
                // Verifica se sobour apenas um na esquerda
                if let left = productCategoryLeft {
                    rows.append(
                        .productCategory(
                            .init(
                                productCategoryLeft: left,
                                productCategoryRight: nil
                            )
                        )
                    )
                }
                */
            }
            
            let viewModel = NewProductCategoryList.Search.ViewModel(rows: rows)
            viewController?.onSearch(viewModel: viewModel)
        }
    }
    
    
    // Handler save
    func save(response: NewProductCategoryList.Save.Response) {
        
        if let error = response.error {
            viewController?.onSave(error: error)
        }
        else {
            let viewModel = NewProductCategoryList.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    
    
}
