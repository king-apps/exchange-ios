//
//  AuthInputEmailPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputEmailPresentationLogic {
    func load(response: AuthInputEmail.Load.Response)
    func save(response: AuthInputEmail.Save.Response)
}


class AuthInputEmailPresenter: AuthInputEmailPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthInputEmailDisplayLogic?
  
    
    // Handler load
    func load(response: AuthInputEmail.Load.Response) {
        
        var rows = [MainTableRow]()
        
        // Input
        rows.append(
            .inputText(
                .init(
                    title: "Input.Email.Title".localized,
                    placeholder: "Input.Email.Placeholder".localized,
                    value: "",
                    error: "",
                    type: .Email,
                    identifier: .Email,
                    isRequired: true,
                    maxLength: 100
                )
            )
        )
        
        let viewModel = AuthInputEmail.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthInputEmail.Save.Response) {
        
        let viewModel = AuthInputEmail.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
