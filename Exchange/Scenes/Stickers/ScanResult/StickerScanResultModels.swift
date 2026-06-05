//
//  StickerScanResultModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum StickerScanResult {
  
    
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
            var sticker: Sticker?
            var category: ProductCategory?
        }
        struct ViewModel {
            var item: StickerListCell.Item
            var categoryUrl: String?
            var color: UIColor
        }
    }

    
    enum Save {
        struct Request {
            
        }
        struct Response {
            var sticker: Sticker?
            var error: String?
        }
        struct ViewModel {
            var item: StickerListCell.Item?
            var error: String?
        }
    }
    
}
