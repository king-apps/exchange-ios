import Foundation


class StickerService {
    
    
    // Var's
    
    
    
    // Construct
    init() {
        
    }
    
    
    // Create defaults
    func createDefaultsIfNeeded(completion: @escaping(_ success: Bool) -> ()) {
        
        do {
            let stickerDatabase = try StickerDatabase()
            let stickerCategoryDatabase = try StickerCategoryDatabase()
            let list: [ProductCategory] = try stickerCategoryDatabase.list()
            
            let api = ProductApi()
            api.categories { categories, error in
                guard let categories else {
                    completion(list.isEmpty == false)
                    return
                }
                
                self.saveCategories(
                    categories,
                    existingCategoryIds: Set(list.map { $0.getId() }),
                    stickerDatabase: stickerDatabase,
                    stickerCategoryDatabase: stickerCategoryDatabase
                )
                
                completion(true)
            }
        } catch {
            completion(false)
        }
        
    }
    
    private func saveCategories(
        _ categories: [ProductCategory],
        existingCategoryIds: Set<Int>,
        stickerDatabase: StickerDatabase,
        stickerCategoryDatabase: StickerCategoryDatabase
    ) {
        for category in categories {
            if existingCategoryIds.contains(category.getId()) {
                let _ = try? stickerCategoryDatabase.update(category)
                continue
            }
            
            let _ = try? stickerCategoryDatabase.insert(category)
            createDefaultStickers(for: category, stickerDatabase: stickerDatabase)
        }
    }
    
    private func createDefaultStickers(for category: ProductCategory, stickerDatabase: StickerDatabase) {
        if category.getCode().uppercased() == "FWC" {
            for i in 1...19 {
                let sticker = Sticker()
                sticker.setIdCategory(category.getId())
                sticker.setTitle(category.getCode())
                sticker.setDescription("\(i)")
                let _ = try? stickerDatabase.insert(sticker)
            }
        }
        else {
            if category.getCode().uppercased() == "CC" {
                for i in 1...14 {
                    let sticker = Sticker()
                    sticker.setIdCategory(category.getId())
                    sticker.setTitle(category.getCode())
                    sticker.setDescription("\(i)")
                    let _ = try? stickerDatabase.insert(sticker)
                }
            }
            else {
                for i in 1...20 {
                    let sticker = Sticker()
                    sticker.setIdCategory(category.getId())
                    sticker.setTitle(category.getCode())
                    sticker.setDescription("\(i)")
                    let _ = try? stickerDatabase.insert(sticker)
                }
            }
        }
        
    }
    
    
}
