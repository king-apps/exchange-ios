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
            
            if list.isEmpty {
                
                let api = ProductApi()
                api.categories { categories, error in
                    
                    if let categories = categories {
                        
                        for category in categories {
                            let _ = try? stickerCategoryDatabase.insert(category)
                            
                            for i in 1...20 {
                                let sticker = Sticker()
                                sticker.setIdCategory(category.getId())
                                sticker.setTitle(category.getCode())
                                sticker.setDescription("\(i)")
                                let _ = try? stickerDatabase.insert(sticker)
                            }
                        }
                        
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
            
                }
    
            }
            else {
                completion(true)
            }
        } catch {
            completion(false)
        }
        
    }
    
    
}

