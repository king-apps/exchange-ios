//
//  StickerCategoryListWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 27/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class StickerCategoryListWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ categories: [ProductCategory]?, _ localConfig: LocalConfig) -> ()) {
        
        let db = try? StickerCategoryDatabase()
        let sortOrder: StickerCategoryDatabase.SortOrder = LocalConfig.shared.getStickerFilterSortByName()
            ? .code
            : .sort
        let categories = try? db?.list(sortOrder: sortOrder)
        let localConfig = LocalConfig.shared
        completion(categories, localConfig)
        
    }
    
    
    // Handler save
    func save(row: Int, categories: [ProductCategory]?, completion: @escaping(_ config: LocalConfig) -> ()) {
    
        if let categories = categories  {
            let category = categories[row]
            LocalConfig.shared.toogleCategory(category.getId())
            LocalConfig.shared.save()
        }
        
        completion(LocalConfig.shared)
        
    }
    
    
    // Handler clear
    func clear(completion: @escaping(_ localConfig: LocalConfig) -> ()) {
        
        LocalConfig.shared.clearCategories()
        LocalConfig.shared.save()
        let localConfig = LocalConfig.shared
        completion(localConfig)
        
    }
    
    
}
