//
//  StickerFilterModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum StickerFilter {
  
    
    enum Load {
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
            var config: LocalConfig
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var collected: Bool
            var missing: Bool
            var duplicated: Bool
            var published: Bool
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
}
