//
//  StickerListModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum StickerList {
    
    enum CollectedOperation {
        case add
        case remove
    }
  
    
    enum Load {
        struct Request {
            var height: CGFloat
        }
        struct Response {
            var keywords: String
            var height: CGFloat
        }
        struct ViewModel {
            var keywords: String
            var rows: [MainTableRow]
        }
    }

    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var list: [StickerCategory]?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    enum UpdateCollected {
        struct Request {
            var id: Int
            var operation: CollectedOperation
        }
        struct Response {
            var id: Int
            var list: [StickerCategory]?
            var error: String?
        }
        struct ViewModel {
            var id: Int
            var rows: [MainTableRow]
            var error: String?
        }
    }
    
    enum CreateProduct {
        struct Request {
            var id: Int
            var image: UIImage
        }
        struct Response {
            var list: [StickerCategory]?
            var product: Product?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    enum Save {
        struct Request {
            var keywords: String
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum PProduct {
        struct Request {
            var id: Int
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            
        }
    }
    
    
}
