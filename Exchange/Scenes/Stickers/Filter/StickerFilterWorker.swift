//
//  StickerFilterWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 25/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class StickerFilterWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // fetch
    func fetch(completion: @escaping(_ config: LocalConfig) -> ()) {
        
        let config = LocalConfig.shared
        completion(config)
        
    }
    
    
    // Handler save
    func save(request: StickerFilter.Save.Request, completion: @escaping() -> ()) {
        
        LocalConfig.shared.setStickerFilterOnlyCollected(request.collected)
        LocalConfig.shared.setStickerFilterOnlyMissing(request.missing)
        LocalConfig.shared.setstickerFilterOnlyDuplicated(request.duplicated)
        LocalConfig.shared.setStickerFilterOnlyPublished(request.published)
        LocalConfig.shared.save()
        completion()
        
    }
    
    
}
