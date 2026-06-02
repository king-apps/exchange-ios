//
//  StickerCategoryListModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum StickerCategoryList {
  
    
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
            var categories: [ProductCategory]?
            var localConfig: LocalConfig
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var row: Int
        }
        struct Response {
            var row: Int
            var categories: [ProductCategory]?
            var localConfig: LocalConfig
        }
        struct ViewModel {
            var row: Int
            var rows: [MainTableRow]
        }
    }

    
    enum Clear {
        struct Request {
            
        }
        struct Response {
            var categories: [ProductCategory]?
            var localConfig: LocalConfig
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
}
