//
//  RootPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol RootPresentationLogic {
    func load(response: Root.Load.Response)
    func controllers(response: Root.Controllers.Response)
    func fcmToken(response: Root.FcmToken.Response)
    func userProfile(response: Root.UserProfile.Response)
}


class RootPresenter: RootPresentationLogic {
  
    
    // Var's
    weak var viewController: RootDisplayLogic?
  
    
    // Handler load
    func load(response: Root.Load.Response) {
        
        let messagesNotViewed = response.user.getMessagesNotViewed()
        let viewModel = Root.Load.ViewModel(messagesNotViewed: messagesNotViewed)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler controllers
    func controllers(response: Root.Controllers.Response) {
        
        let viewModel = Root.Controllers.ViewModel(list: response.list)
        viewController?.onControllers(viewModel: viewModel)
        
    }
    
    
    // Handler fcm token
    func fcmToken(response: Root.FcmToken.Response) {
        
        if let error = response.error {
            viewController?.onFcmToken(error: error)
        }
        else {
            let viewModel = Root.FcmToken.ViewModel()
            viewController?.onFcmToken(viewModel: viewModel)
        }
        
    }
    
    
    // Handler user profile
    func userProfile(response: Root.UserProfile.Response) {
        
        if let user = response.user {
            let messagesNotViewed = user.getMessagesNotViewed()
            let viewModel = Root.UserProfile.ViewModel(messagesNotViewed: messagesNotViewed)
            viewController?.onUserProfile(viewModel: viewModel)
        }
        else {
            let error = response.error ?? "Error.500".localized
            viewController?.onUserProfile(error: error)
        }
    }
    
    
}
