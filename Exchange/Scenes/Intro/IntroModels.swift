//
//  IntroModels.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum Intro {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Language {
        struct Request {
            
        }
        struct Response {
            var language: String
        }
        struct ViewModel {
            var language: String
        }
    }
    
    
    enum Remote {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum AppOpen {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Auth {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Redirect {
        struct Request {
            
        }
        struct Response {
            var isAuth: Bool
        }
        struct ViewModel {
            var isAuth: Bool
        }
    }

    
}
