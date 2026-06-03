//
//  RootModels.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum Root {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var user: User
        }
        struct ViewModel {
            var messagesNotViewed: Int
        }
    }

    enum Controllers {
        struct Request {
            
        }
        struct Response {
            var list: [RootController]
        }
        struct ViewModel {
            var list: [RootController]
        }
    }
    
    enum FcmToken {
        struct Request {
            
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
    enum UserProfile {
        struct Request {
            
        }
        struct Response {
            var user: User?
            var error: String?
        }
        struct ViewModel {
            var messagesNotViewed: Int
        }
    }
 
    
    struct RootController {
        var storyboard: String
        var title: String
        var icon: AppTheme.Icon
    }
    
    
}
