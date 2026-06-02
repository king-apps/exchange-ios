//
//  NewProductMainPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 30/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol NewProductMainPresentationLogic {
    func load(response: NewProductMain.Load.Response)
    func save(response: NewProductMain.Save.Response)
}


class NewProductMainPresenter: NewProductMainPresentationLogic {
  
    
    // Var's
    weak var viewController: NewProductMainDisplayLogic?
  
    
    // Handler load
    func load(response: NewProductMain.Load.Response) {
        
        let viewModel = NewProductMain.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: NewProductMain.Save.Response) {
        
        let viewModel = NewProductMain.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
    }
    
    
}
