import Foundation


class LocalConfig {
    
    
    // Var's
    public static let shared = LocalConfig()
    private var language: String
    private var radius: Int
    private var categories: [Int]
    
    private var stickerFilterKeywords: String
    private var stickerFilterOnlyCollected: Bool
    private var stickerFilterOnlyMissing: Bool
    private var stickerFilterOnlyDuplicated: Bool
    private var stickerFilterOnlyPublished: Bool
    private var stickerFilterSortByName: Bool
    private var stickerFilterLocked: Bool
    private var stickerFilterCategories: [Int]
    
    private var hasChanged: Bool

    
    
    // Keys
    private enum Key {
        static let language = "LocalConfig.Language"
        static let radius = "LocalConfig.Radius"
        static let categories = "LocalConfig.Categories"
        
        static let stickerFilterKeywords = "LocalConfig.StickerFilterKeywords"
        static let stickerFilterOnlyCollected = "LocalConfig.StickerFilterOnlyCollected"
        static let stickerFilterOnlyMissing = "LocalConfig.StickerFilterOnlyMissing"
        static let stickerFilterOnlyDuplicated = "LocalConfig.StickerFilterOnlyDuplicated"
        static let stickerFilterOnlyPublished = "LocalConfig.StickerFilterOnlyPublished"
        static let stickerFilterSortByName = "LocalConfig.StickerFilterSortByName"
        static let stickerFilterLocked = "LocalConfig.StickerFilterLocked"
        static let stickerFilterCategories = "LocalConfig.StickerFilterCategories"
    }
    
    
    // Construct
    init() {
        language = ""
        radius = RemoteConfig.shared.getMatchFilterRadiusMax()
        categories = []
        
        stickerFilterKeywords = ""
        stickerFilterOnlyCollected = false
        stickerFilterOnlyMissing = false
        stickerFilterOnlyDuplicated = false
        stickerFilterOnlyPublished = false
        stickerFilterSortByName = false
        stickerFilterLocked = false
        stickerFilterCategories = []
        
        hasChanged = false
    }
    
    
    // Save
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(language, forKey: Key.language)
        defaults.set(radius, forKey: Key.radius)
        defaults.set(categories, forKey: Key.categories)
        
        defaults.set(stickerFilterKeywords, forKey: Key.stickerFilterKeywords)
        defaults.set(stickerFilterOnlyCollected, forKey: Key.stickerFilterOnlyCollected)
        defaults.set(stickerFilterOnlyMissing, forKey: Key.stickerFilterOnlyMissing)
        defaults.set(stickerFilterOnlyDuplicated, forKey: Key.stickerFilterOnlyDuplicated)
        defaults.set(stickerFilterOnlyPublished, forKey: Key.stickerFilterOnlyPublished)
        defaults.set(stickerFilterSortByName, forKey: Key.stickerFilterSortByName)
        defaults.set(stickerFilterLocked, forKey: Key.stickerFilterLocked)
        defaults.set(stickerFilterCategories, forKey: Key.stickerFilterCategories)
        
        defaults.synchronize()
    }
    
    
    // Load
    func load() {
        let defaults = UserDefaults.standard
        language << defaults.value(forKey: Key.language)
        radius << defaults.value(forKey: Key.radius)
        if let values = defaults.value(forKey: Key.categories) as? [Int] {
            categories = values
        }
        
        stickerFilterKeywords << defaults.value(forKey: Key.stickerFilterKeywords)
        stickerFilterOnlyCollected << defaults.value(forKey: Key.stickerFilterOnlyCollected)
        stickerFilterOnlyMissing << defaults.value(forKey: Key.stickerFilterOnlyMissing)
        stickerFilterOnlyDuplicated << defaults.value(forKey: Key.stickerFilterOnlyDuplicated)
        stickerFilterOnlyPublished << defaults.value(forKey: Key.stickerFilterOnlyPublished)
        stickerFilterSortByName << defaults.value(forKey: Key.stickerFilterSortByName)
        stickerFilterLocked << defaults.value(forKey: Key.stickerFilterLocked)
        if let values = defaults.value(forKey: Key.stickerFilterCategories) as? [Int] {
            stickerFilterCategories = values
        }
    }
    
    
    // Clear
    func clear() {
        radius = RemoteConfig.shared.getMatchFilterRadiusMax()
        categories = []
        
        stickerFilterKeywords = ""
        stickerFilterOnlyCollected = false
        stickerFilterOnlyMissing = false
        stickerFilterOnlyDuplicated = false
        stickerFilterOnlyPublished = false
        stickerFilterSortByName = false
        stickerFilterLocked = false
        stickerFilterCategories = []
        
        hasChanged = true
        save()
    }
    
    
    // Set's
    func setLanguage(_ value: String) {
        language = value
    }
    func setRadius(_ value: Int) {
        self.radius = value
    }
    func setCategories(_ value: [Int]) {
        self.categories = value
    }

    func setStickerFilterKeywords(_ value: String) {
        self.stickerFilterKeywords = value
    }
    func setStickerFilterOnlyCollected(_ value: Bool) {
        self.stickerFilterOnlyCollected = value
    }
    func setStickerFilterOnlyMissing(_ value: Bool) {
        self.stickerFilterOnlyMissing = value
    }
    func setstickerFilterOnlyDuplicated(_ value: Bool) {
        self.stickerFilterOnlyDuplicated = value
    }
    func setStickerFilterOnlyPublished(_ value: Bool) {
        self.stickerFilterOnlyPublished = value
    }
    func setStickerFilterSortByName(_ value: Bool) {
        self.stickerFilterSortByName = value
    }
    func setStickerFilterLocked(_ value: Bool) {
        self.stickerFilterLocked = value
    }
    func setStickerFilterCategories(_ value: [Int]) {
        self.stickerFilterCategories = value
    }
    
    func setHasChanged(_ value: Bool) {
        hasChanged = value
    }
    
    
    // Get's
    func getLanguage() -> String {
        return self.language
    }
    func getRadius() -> Int {
        return self.radius
    }
    func getCategories() -> [Int] {
        return self.categories
    }
    
    func getStickerFilterKeywords() -> String {
        return stickerFilterKeywords
    }
    func getStickerFilterOnlyCollected() -> Bool {
        return stickerFilterOnlyCollected
    }
    func getStickerFilterOnlyMissing() -> Bool {
        return stickerFilterOnlyMissing
    }
    func getStickerFilterOnlyDuplicated() -> Bool {
        return stickerFilterOnlyDuplicated
    }
    func getStickerFilterOnlyPublished() -> Bool {
        return stickerFilterOnlyPublished
    }
    func getStickerFilterSortByName() -> Bool {
        return stickerFilterSortByName
    }
    func getStickerFilterLocked() -> Bool {
        return stickerFilterLocked
    }
    func getStickerFilterCategories() -> [Int] {
        return stickerFilterCategories
    }
    
    func getHasChanged() -> Bool {
        return hasChanged
    }
    
    
    func toogleCategory(_ category: Int) {
        if !categories.contains(category) {
            categories.append(category)
        }
        else {
            categories.removeAll(where: {$0 == category})
        }
    }
    func clearCategories() {
        categories.removeAll()
    }
    func toogleStickerFilterCategory(_ category: Int) {
        if !stickerFilterCategories.contains(category) {
            stickerFilterCategories.append(category)
        }
        else {
            stickerFilterCategories.removeAll(where: {$0 == category})
        }
    }
    func clearStickerFilterCategories() {
        stickerFilterCategories.removeAll()
    }
    
    func filterIsActive() -> Bool {
        let isActive = categories.count > 0 || radius != RemoteConfig.shared.getMatchFilterRadiusMax()
        return isActive
    }
    func filterStickerIsActive() -> Bool {
        
        let isActive = stickerFilterOnlyMissing || stickerFilterOnlyCollected || stickerFilterOnlyPublished || stickerFilterOnlyDuplicated || !stickerFilterKeywords.isEmpty || !stickerFilterCategories.isEmpty
    
        return isActive
        
    }
    
}
