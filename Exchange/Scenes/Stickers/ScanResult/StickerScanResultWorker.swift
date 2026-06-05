//
//  StickerScanResultWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 05/06/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class StickerScanResultWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping() -> ()) {
        completion()
    }
    func fetchCategory(id: Int?) -> ProductCategory? {
        do {
            return try StickerCategoryDatabase().get(id: id)
        }
        catch {
            return nil
        }
    }
    
    
    // Handler save
    func save(sticker: Sticker?, completion: @escaping(_ sticker: Sticker?, _ error: String?) -> ()) {
        do {
            guard let sticker else {
                completion(nil, "Error.500".localized)
                return
            }
            
            sticker.addCollected()
            try StickerDatabase().update(sticker)
            
            completion(sticker, nil)
        }
        catch {
            completion(sticker, "Error.500".localized)
        }
    }
    
}
