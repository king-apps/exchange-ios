//
//  StickerListWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class StickerListWorker {
   
    
    // Handler load
    func load(completion: @escaping(_ keywords: String) -> ()) {
        completion(LocalConfig.shared.getStickerFilterKeywords())
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ products: [Product]?, _ list: [StickerCategory]?, _ error: String?) -> ()) {
        
        do {
            let listResponse = try fetchLocalStickerCategories()
            
            ProductApi().list { products, error in
                if let products {
                    self.applyProductImages(products: products, to: listResponse)
                }
                
                completion(products, self.applyStickerFilters(to: listResponse), error)
            }
        }
        catch {
            completion(nil, nil, "Error.500".localized)
        }
       
    }
    
    
    // Handler update collected
    func updateCollected(
        id: Int,
        operation: StickerList.CollectedOperation,
        list: [StickerCategory]?,
        completion: @escaping(_ list: [StickerCategory]?, _ error: String?) -> ()
    ) {
        
        do {
            let stickerDatabase = try StickerDatabase()
            let sticker = try findSticker(id: id, in: list) ?? stickerDatabase.get(id: id)
            
            guard let sticker else {
                completion(list, "Error.500".localized)
                return
            }
            
            switch operation {
            case .add:
                sticker.addCollected()
                try stickerDatabase.update(sticker)
                completion(filteredStickerCategories(from: list), nil)
            case .remove:
                let previousCollected = sticker.getCollected()
                let productId = sticker.getIdProduct()
                sticker.removeCollected()
                
                guard sticker.getCollected() <= 1 && productId > 0 else {
                    try stickerDatabase.update(sticker)
                    completion(filteredStickerCategories(from: list), nil)
                    return
                }
                
                ProductApi().delete(id: productId) { error in
                    if let error {
                        sticker.setCollected(previousCollected)
                        completion(self.filteredStickerCategories(from: list), error)
                        return
                    }
                    
                    sticker.setIdProduct(0)
                    sticker.setImageUrl("")
                    sticker.setImage(nil)
                    
                    do {
                        try stickerDatabase.update(sticker)
                        completion(self.filteredStickerCategories(from: list), nil)
                    }
                    catch {
                        completion(self.filteredStickerCategories(from: list), "Error.500".localized)
                    }
                }
            }            
        }
        catch {
            completion(list, "Error.500".localized)
        }
        
    }
    
    
    // Handler create product
    func createProduct(
        id: Int,
        image: UIImage,
        list: [StickerCategory]?,
        completion: @escaping(_ list: [StickerCategory]?, _ product: Product?, _ error: String?) -> ()
    ) {
        
        do {
            let stickerDatabase = try StickerDatabase()
            
            guard
                let sticker = try findSticker(id: id, in: list) ?? stickerDatabase.get(id: id),
                let data = image.resize(
                    to: CGSizeMake(
                        CGFloat(RemoteConfig.shared.getProductImageMaxWidth()),
                        CGFloat(RemoteConfig.shared.getProductImageMaxHeight())
                    ))?.pngData()
            else {
                completion(list, nil, "Alert.Generic.Error".localized)
                return
            }
            
            guard sticker.getCollected() > 1 else {
                completion(list, nil, "Alert.Generic.Error".localized)
                return
            }
            
            let request = ProductSaveRequestDTO(
                title: makeProductTitle(sticker: sticker),
                categoryId: sticker.getIdCategory(),
                images: [data]
            )
            
            ProductApi().save(request: request) { product, error in
                if let error {
                    completion(list, nil, error)
                    return
                }
                
                guard let product else {
                    completion(list, nil, "Alert.Generic.Error".localized)
                    return
                }
                
                sticker.setIdProduct(product.getId())
                sticker.setImageUrl(product.images.first?.getUrl() ?? "")
                sticker.setImage(image)
                
                do {
                    try stickerDatabase.update(sticker)
                    completion(self.filteredStickerCategories(from: list), product, nil)
                }
                catch {
                    completion(list, nil, "Alert.Generic.Error".localized)
                }
            }
        }
        catch {
            completion(list, nil, "Alert.Generic.Error".localized)
        }
        
    }
    
    private func findSticker(id: Int, in list: [StickerCategory]?) -> Sticker? {
        guard let list else { return nil }
        
        for stickerCategory in list {
            if let sticker = stickerCategory.stickers.first(where: { $0.getId() == id }) {
                return sticker
            }
        }
        
        return nil
    }
    
    private func filteredStickerCategories(from list: [StickerCategory]?) -> [StickerCategory]? {
        guard let list else {
            return try? applyStickerFilters(to: fetchLocalStickerCategories())
        }
        
        return applyStickerFilters(to: list)
    }
    
    private func fetchLocalStickerCategories() throws -> [StickerCategory] {
        let stickerDatabase = try StickerDatabase()
        let stickerCategoryDatabase = try StickerCategoryDatabase()
        let sortOrder: StickerCategoryDatabase.SortOrder = LocalConfig.shared.getStickerFilterSortByName()
            ? .code
            : .sort
        let listProductCategory: [ProductCategory] = try stickerCategoryDatabase.list(sortOrder: sortOrder)
        
        var listResponse = [StickerCategory]()
        
        for productCategory in listProductCategory {
            let stickerCategory = StickerCategory()
            stickerCategory.category = productCategory
            stickerCategory.stickers = try stickerDatabase.list(idCategory: productCategory.getId())
            listResponse.append(stickerCategory)
        }
        
        return listResponse
    }
    
    private func applyStickerFilters(to list: [StickerCategory]) -> [StickerCategory] {
        let config = LocalConfig.shared
        let onlyCollected = config.getStickerFilterOnlyCollected()
        let onlyMissing = config.getStickerFilterOnlyMissing()
        let onlyDuplicated = config.getStickerFilterOnlyDuplicated()
        let onlyPublished = config.getStickerFilterOnlyPublished()
        let categoryIds = Set(config.getCategories())
        let shouldFilterCategories = categoryIds.isEmpty == false
        let keywords = normalizedSearchTerms(config.getStickerFilterKeywords())
        let shouldFilterKeywords = keywords.isEmpty == false
        
        guard shouldFilterCategories || onlyCollected || onlyMissing || onlyDuplicated || onlyPublished || shouldFilterKeywords else {
            return list
        }
        
        return list.compactMap { stickerCategory in
            if shouldFilterCategories && categoryIds.contains(stickerCategory.category.getId()) == false {
                return nil
            }
            
            let stickers = stickerCategory.stickers.filter {
                shouldShowSticker(
                    $0,
                    onlyCollected: onlyCollected,
                    onlyMissing: onlyMissing,
                    onlyDuplicated: onlyDuplicated,
                    onlyPublished: onlyPublished,
                    keywords: keywords
                )
            }
            
            guard stickers.isEmpty == false else { return nil }
            
            let filteredStickerCategory = StickerCategory()
            filteredStickerCategory.category = stickerCategory.category
            filteredStickerCategory.stickers = stickers
            return filteredStickerCategory
        }
    }
    
    private func shouldShowSticker(
        _ sticker: Sticker,
        onlyCollected: Bool,
        onlyMissing: Bool,
        onlyDuplicated: Bool,
        onlyPublished: Bool,
        keywords: [String]
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
        
        if keywords.isEmpty == false && matchesKeywords(sticker: sticker, keywords: keywords) == false {
            return false
        }
        
        return true
    }
    
    private func matchesKeywords(sticker: Sticker, keywords: [String]) -> Bool {
        let searchableText = normalize(makeProductTitle(sticker: sticker))
        
        return keywords.allSatisfy { searchableText.contains($0) }
    }
    
    private func normalizedSearchTerms(_ value: String) -> [String] {
        normalize(value)
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { $0.isEmpty == false }
    }
    
    private func applyProductImages(products: [Product], to list: [StickerCategory]) {
        let productIds = Set(products.map { $0.getId() })
        let stickerDatabase = try? StickerDatabase()
        let stickers = list.flatMap { $0.stickers }
        
        for sticker in stickers where sticker.getIdProduct() > 0 && productIds.contains(sticker.getIdProduct()) == false {
            sticker.setIdProduct(0)
            sticker.setImageUrl("")
            sticker.setImage(nil)
            let _ = try? stickerDatabase?.update(sticker)
        }
        
        for product in products {
            guard let sticker = findSticker(for: product, in: stickers) else {
                continue
            }
            
            let imageUrl = product.images.first?.getUrl() ?? ""
            let shouldPersist = sticker.getIdProduct() != product.getId()
                || sticker.getImageUrl() != imageUrl
                || sticker.getCollected() < 2
            
            sticker.setIdProduct(product.getId())
            sticker.setImageUrl(imageUrl)
            
            if sticker.getCollected() < 2 {
                sticker.setCollected(2)
            }
            
            if shouldPersist {
                let _ = try? stickerDatabase?.update(sticker)
            }
        }
    }
    
    private func findSticker(for product: Product, in stickers: [Sticker]) -> Sticker? {
        if let sticker = stickers.first(where: { $0.getIdProduct() == product.getId() }) {
            return sticker
        }
        
        return stickers.first {
            $0.getIdCategory() == product.category.getId()
                && normalize(makeProductTitle(sticker: $0)) == normalize(product.getTitle())
        }
    }
    
    private func makeProductTitle(sticker: Sticker) -> String {
        "\(sticker.getTitle()) \(sticker.getDescription())"
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func normalize(_ value: String) -> String {
        value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .lowercased()
    }
    
    
    // Handler save
    func save(keywords: String, completion: @escaping() -> ()) {
        
        LocalConfig.shared.setStickerFilterKeywords(keywords)
        LocalConfig.shared.save()
        completion()
        
    }
    
    
    // Handler product
    func product(id: Int, products: [Product]?, completion: @escaping(_ product: Product?) -> ()) {
        let product = products?.first(where: {$0.getId() == id})
        completion(product)
    }
    
    
}
