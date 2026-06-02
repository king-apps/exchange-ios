//
//  AuthTrackingModels.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum AuthTracking {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
    enum Tracking {
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
