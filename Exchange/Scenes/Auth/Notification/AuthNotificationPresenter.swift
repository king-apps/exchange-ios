//
//  AuthNotificationPresenter.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthNotificationPresentationLogic {
    func load(response: AuthNotification.Load.Response)
    func notification(response: AuthNotification.Notification.Response)
    func save(response: AuthNotification.Save.Response)
}


class AuthNotificationPresenter: AuthNotificationPresentationLogic {
  
    
    // Var's
    weak var viewController: AuthNotificationDisplayLogic?
  
    
    // Handler load
    func load(response: AuthNotification.Load.Response) {
        
        let viewModel = AuthNotification.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler notification
    func notification(response: AuthNotification.Notification.Response) {
        
        let viewModel = AuthNotification.Notification.ViewModel(granted: response.granted)
        viewController?.onNotification(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: AuthNotification.Save.Response) {
        
        let viewModel = AuthNotification.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
}
