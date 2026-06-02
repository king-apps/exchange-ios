//
//  ProfileEmailTokenPresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileEmailTokenPresentationLogic {
    func load(response: ProfileEmailToken.Load.Response)
    func save(response: ProfileEmailToken.Save.Response)
}


class ProfileEmailTokenPresenter: ProfileEmailTokenPresentationLogic {
  
    
    // Var's
    weak var viewController: ProfileEmailTokenDisplayLogic?
  
    
    // Handler load
    func load(response: ProfileEmailToken.Load.Response) {
        
        var rows = [MainTableRow]()
        
        // Title
        rows.append(.spacing(.init(size: .xl)))
        rows.append(
            .textHeadingLg(
                .init(
                    text: "AuthInputToken.Title".localized,
                    align: .center
                )
            )
        )
        
        
        
        // Subtitle
        rows.append(.spacing(.init(size: .lg)))
        let text = "AuthInputToken.Description".localized.replacingOccurrences(of: "{$0}", with: response.email ?? "")
        rows.append(
            .textBody(
                .init(
                    text: text,
                    align: .center,
                    color: .textOnSurfaceSecondary
                )
            )
        )
        
        // Token
        rows.append(.spacing(.init(size: .xxl)))
        rows.append(
            .inputToken(
                .init(
                    token: "",
                    style: .default
                )
            )
        )
        
        let viewModel = ProfileEmailToken.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: ProfileEmailToken.Save.Response) {
        
        if let _ = response.error {
            
            var rows = [MainTableRow]()
            
            // Title
            rows.append(.spacing(.init(size: .xl)))
            rows.append(
                .textHeadingLg(
                    .init(
                        text: "AuthInputToken.Title".localized,
                        align: .center
                    )
                )
            )
            
            
            
            // Subtitle
            rows.append(.spacing(.init(size: .lg)))
            let text = "AuthInputToken.Description".localized.replacingOccurrences(of: "{$0}", with: response.email ?? "")
            rows.append(
                .textBody(
                    .init(
                        text: text,
                        align: .center,
                        color: .textOnSurfaceSecondary
                    )
                )
            )
            
            // Token
            rows.append(.spacing(.init(size: .xxl)))
            rows.append(
                .inputToken(
                    .init(
                        token: response.token,
                        style: .error
                    )
                )
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
            let viewModel = ProfileEmailToken.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    
    
}
