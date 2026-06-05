//
//  StickerScanModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum StickerScan {
  
    struct Code {
        let categoryCode: String
        let number: Int
        
        var rawValue: String {
            return "\(categoryCode) \(number)"
        }
    }
    
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    enum RecognizeText {
        struct Request {
            let texts: [String]
        }
        struct Response {
            let code: Code?
            let sticker: Sticker?
        }
        struct ViewModel {
            let code: Code
            let sticker: Sticker?
        }
    }

    
}
