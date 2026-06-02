//
//  AuthInputTokenPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthInputTokenPresentationLogic {
    func load(response: AuthInputToken.Load.Response)
    func save(response: AuthInputToken.Save.Response)
}


class AuthInputTokenPresenter: AuthInputTokenPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthInputTokenDisplayLogic?
  
    
    // Handler load
    func load(response: AuthInputToken.Load.Response) {
        
        let rows = getListDefault(
            style: .default,
            token: ""
        )
        
        let email = response.email ?? ""
        let description = "AuthInputToken.Description".localized.replacingOccurrences(of: "{$0}", with: email)
        
        let viewModel = AuthInputToken.Load.ViewModel(
            rows: rows,
            description: description
        )
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler default list
    private func getListDefault(style: InputTokenCell.Style, token: String) -> [MainTableRow] {
        
        var rows = [MainTableRow]()

        // Token
        rows.append(
            .inputToken(
                .init(
                    token: token,
                    style: style
                )
            )
        )
        
        return rows
    }
    
    
    // Handler save
    func save(response: AuthInputToken.Save.Response) {
        
        if let _ = response.error {
            var rows = getListDefault(
                style: .error,
                token: response.token
            )
            
            // Adding error
            rows.append(
                .textCaption(
                    .init(
                        text: "Input.Token.Error.Wrong".localized,
                        align: .center,
                        color: AppTheme.Colors.error500
                    )
                )
            )
            viewController?.onSave(rows: rows)
        }
        else {
            let viewModel = AuthInputToken.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    

    
    
}
