//
//  AuthNotificationInteractor.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol AuthNotificationBusinessLogic {
    func load(request: AuthNotification.Load.Request)
    func notification(request: AuthNotification.Notification.Request)
    func save(request: AuthNotification.Save.Request)
}


protocol AuthNotificationDataStore {
    var localConfig: LocalConfig? { get set }
}


class AuthNotificationInteractor: AuthNotificationBusinessLogic, AuthNotificationDataStore {
    
    
    // Var's
    var presenter: AuthNotificationPresentationLogic?
    var worker = AuthNotificationWorker()
    
    var localConfig: LocalConfig?
    
    private func dispatchToMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        }
        else {
            DispatchQueue.main.async(execute: block)
        }
    }
  
    
    // Handler load
    func load(request: AuthNotification.Load.Request) {
        
        worker.load {
            let response = AuthNotification.Load.Response()
            self.dispatchToMain {
                self.presenter?.load(response: response)
            }
        }
        
    }
    
    
    // Handler notification
    func notification(request: AuthNotification.Notification.Request) {
        
        worker.notification { granted in
            let response = AuthNotification.Notification.Response(granted: granted)
            self.dispatchToMain {
                self.presenter?.notification(response: response)
            }
        }
        
    }
    
    
    // Handler save
    func save(request: AuthNotification.Save.Request) {
        
        worker.save(granted: request.granted) {
            let response = AuthNotification.Save.Response()
            self.dispatchToMain {
                self.presenter?.save(response: response)
            }
        }
        
    }
    
    
}
