//
//  ProfileEmailPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailPresentationLogic {
    func load(response: ProfileEmail.Load.Response)
    func save(response: ProfileEmail.Save.Response)
}


class ProfileEmailPresenter: ProfileEmailPresentationLogic {
  
    
    // Var's
    weak var viewController: ProfileEmailDisplayLogic?
  
    
    // Handler load
    func load(response: ProfileEmail.Load.Response) {
        
        var rows = [MainTableRow]()
        
        // Title
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textHeadingLg(
                .init(
                    text: "AuthInputEmail.Title".localized,
                    align: .center
                )
            )
        )
        
        
        
        // Subtitle
        rows.append(.spacing(.init(size: .lg)))
        rows.append(
            .textBody(
                .init(
                    text: "AuthInputEmail.Description".localized,
                    align: .center,
                    color: .textOnSurfaceSecondary
                )
            )
        )
        
        
        
        // Input
        rows.append(.spacing(.init(size: .xxl)))
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
        
        let viewModel = ProfileEmail.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: ProfileEmail.Save.Response) {
        
        if let error = response.error {
            viewController?.onSave(error: error)
        }
        else {
            let viewModel = ProfileEmail.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
    }
    
}
