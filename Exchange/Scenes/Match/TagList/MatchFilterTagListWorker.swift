import UIKit


class MatchFilterTagListWorker {
   
    
    // Handler load
    func load(completion: @escaping(_ list: [ProductCategory]?, _ error: String?) -> ()) {
        fetch(completion: completion)
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ list: [ProductCategory]?, _ error: String?) -> ()) {
        
        do {
            let categoryDatabase = try StickerCategoryDatabase()
            let stickerDatabase = try StickerDatabase()
            let config = LocalConfig.shared
            let categories = try categoryDatabase.list()
            
            let filteredCategories = try categories.filter { category in
                let stickers = try stickerDatabase.list(idCategory: category.getId())
                return shouldShowCategory(stickers: stickers, config: config)
            }
            
            completion(filteredCategories, nil)
        }
        catch {
            completion(nil, "Error.500".localized)
        }
        
    }
    
    
    // Selected product categories ids
    func getSettingsProductCategories() -> [Int] {
        
        let ids = LocalConfig.shared.getCategories()
        return ids
        
    }


    // Handler select
    func select(categoryId: Int, selectedProductCategories: [Int], completion: @escaping(_ selectedProductCategories: [Int]) -> ()) {
        
        var ids = selectedProductCategories
        
        if ids.contains(categoryId) {
            ids.removeAll { $0 == categoryId }
        }
        else {
            ids.append(categoryId)
        }
        
        completion(ids)
        
    }
    
    
    // Handler save
    func save(ids: [Int], productCategories: [ProductCategory]?, completion: @escaping() -> ()) {
   
       // let count  = productCategories?.count ?? 0
        
        LocalConfig.shared.setCategories(ids)
        LocalConfig.shared.setHasChanged(true)
        LocalConfig.shared.save()
        
        completion()
        
    }
    
    private func shouldShowCategory(stickers: [Sticker], config: LocalConfig) -> Bool {
        let onlyCollected = config.getStickerFilterOnlyCollected()
        let onlyMissing = config.getStickerFilterOnlyMissing()
        let onlyDuplicated = config.getStickerFilterOnlyDuplicated()
        let onlyPublished = config.getStickerFilterOnlyPublished()
        
        guard onlyCollected || onlyMissing || onlyDuplicated || onlyPublished else {
            return true
        }
        
        return stickers.contains {
            shouldShowSticker(
                $0,
                onlyCollected: onlyCollected,
                onlyMissing: onlyMissing,
                onlyDuplicated: onlyDuplicated,
                onlyPublished: onlyPublished
            )
        }
    }
    
    private func shouldShowSticker(
        _ sticker: Sticker,
        onlyCollected: Bool,
        onlyMissing: Bool,
        onlyDuplicated: Bool,
        onlyPublished: Bool
    ) -> Bool {
        
        if onlyCollected && sticker.getCollected() <= 0 {
            return false
        }
        
        if onlyMissing && sticker.getCollected() > 0 {
            return false
        }
        
        if onlyDuplicated && sticker.getCollected() <= 1 {
            return false
        }
        
        if onlyPublished && sticker.getIdProduct() <= 0 {
            return false
        }
        
        return true
    }
    
    
}
