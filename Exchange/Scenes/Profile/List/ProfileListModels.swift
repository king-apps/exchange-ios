//
//  ProfileListModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ProfileList {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum BoostStatus {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var auth: Auth
            var user: User
            var remote: RemoteConfig
            var showAds: Bool
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var notificationMatch: Bool
            var notificationMessage: Bool
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
    enum DeleteAccount {
        struct Request {
            
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Logout {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Avatar {
        struct Request {
            var image: UIImage
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
}
