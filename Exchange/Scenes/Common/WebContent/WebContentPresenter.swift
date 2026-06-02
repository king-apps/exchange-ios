//
//  WebContentPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol WebContentPresentationLogic {
    func load(response: WebContent.Load.Response)
    func fetch(response: WebContent.Fetch.Response)
}


class WebContentPresenter: WebContentPresentationLogic {
  
    
    // Var's
    weak var viewController: WebContentDisplayLogic?
  
    
    // Handler load
    func load(response: WebContent.Load.Response) {
        
        let viewModel = WebContent.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: WebContent.Fetch.Response) {
        
        if let error = response.error {
            viewController?.onFetch(error: error)
            return
        }
        
        if let url = response.url {
            let viewModel = WebContent.Fetch.ViewModel(url: url)
            viewController?.onFetch(viewModel: viewModel)
        }
        else {
            let error = "Não foi possível carregar este conteúdo."
            viewController?.onFetch(error: error)
        }
        
    }
    
    
}
