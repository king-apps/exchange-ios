//
//  AuthInputNamePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 13/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputNamePresentationLogic {
    func load(response: AuthInputName.Load.Response)
    func save(response: AuthInputName.Save.Response)
}


class AuthInputNamePresenter: AuthInputNamePresentationLogic {
  
    
    // Var's
    weak var viewController: AuthInputNameDisplayLogic?
  
    
    // Handler load
    func load(response: AuthInputName.Load.Response) {
        
        var rows = [MainTableRow]()
        
        // Input
        rows.append(
            .inputText(
                .init(
                    title: "Input.Name.Title".localized,
                    placeholder: "Input.Name.Placeholder".localized,
                    value: "",
                    error: "",
                    type: .Name,
                    identifier: .Name,
                    isRequired: true,
                    maxLength: 100
                )
            )
        )
        
        let viewModel = AuthInputName.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthInputName.Save.Response) {
        
        let viewModel = AuthInputName.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
