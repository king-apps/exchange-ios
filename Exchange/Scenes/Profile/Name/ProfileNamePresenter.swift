//
//  ProfileNamePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileNamePresentationLogic {
    func load(response: ProfileName.Load.Response)
    func save(response: ProfileName.Save.Response)
}


class ProfileNamePresenter: ProfileNamePresentationLogic {
  
    
    // Var's
    weak var viewController: ProfileNameDisplayLogic?
  
    
    // Handler load
    func load(response: ProfileName.Load.Response) {
        
        
        var rows = [MainTableRow]()
        
        // Title
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textHeadingLg(
                .init(
                    text: "Profile.Name.Title".localized,
                    align: .center
                )
            )
        )
        
        
        
        // Subtitle
        rows.append(.spacing(.init(size: .lg)))
        rows.append(
            .textBody(
                .init(
                    text: "Profile.Name.Description".localized,
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
                    title: "Input.Name.Title".localized,
                    placeholder: "Input.Name.Placeholder".localized,
                    value: "",
                    error: "",
                    type: .Name,
                    identifier: .Name,
                    isRequired: true,
                    maxLength: 50
                )
            )
        )
        
        let viewModel = ProfileName.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: ProfileName.Save.Response) {
        
        if let error = response.error {
            viewController?.onSave(error: error)
        }
        else {
            let viewModel = ProfileName.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    
}
