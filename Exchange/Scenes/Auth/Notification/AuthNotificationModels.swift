//
//  AuthNotificationModels.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 01/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum AuthNotification {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Notification {
        struct Request {
            
        }
        struct Response {
            var granted: Bool
        }
        struct ViewModel {
            var granted: Bool
        }
    }
    
    
    enum Save {
        struct Request {
            var granted: Bool
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
}
