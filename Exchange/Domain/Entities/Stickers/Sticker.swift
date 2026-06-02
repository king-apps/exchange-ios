import UIKit


class Sticker {
    
    
    // Var's
    private var index: Int
    private var id: Int
    private var idCategory: Int
    private var idProduct: Int
    private var title: String
    private var description: String
    private var collected: Int
    private var imageUrl: String
    private var image: UIImage?
    
    
    // Init
    init() {
        index = 0
        id = 0
        idCategory = 0
        idProduct = 0
        title = ""
        description = ""
        collected = 0
        imageUrl = ""
        image = nil
    }
    
    
    // Set's
    func setIndex(_ value: Int) {
        self.index = value
    }
    func setId(_ value: Int) {
        self.id = value
    }
    func setIdCategory(_ value: Int) {
        self.idCategory = value
    }
    func setIdProduct(_ value: Int) {
        self.idProduct = value
    }
    func setTitle(_ value: String) {
        self.title = value
    }
    func setDescription(_ value: String) {
        self.description = value
    }
    func setCollected(_ value: Int) {
        self.collected = value
    }
    func setImageUrl(_ value: String) {
        self.imageUrl = value
    }
    func setImage(_ value: UIImage?) {
        self.image = value
    }
    
    
    // Get's
    func getIndex() -> Int {
        return index
    }
    func getId() -> Int {
        return id
    }
    func getIdCategory() -> Int {
        return idCategory
    }
    func getIdProduct() -> Int {
        return idProduct
    }
    func getTitle() -> String {
        return title
    }
    func getDescription() -> String {
        return description
    }
    func getCollected() -> Int {
        return collected
    }
    func getImageUrl() -> String {
        return imageUrl
    }
    func getImage() -> UIImage? {
        return image
    }
    
    
    // Helpers
    func addCollected() {
        collected += 1
    }
    func removeCollected() {
        collected -= 1
        if collected < 0 {
            collected = 0
        }
    }
    
    
}
