import Foundation


enum ProductStatus: String {
    case `default` = ""
}


class Product {
    
    private var id: Int
    private var title: String
    private var description: String
    private var status: ProductStatus
    var category: ProductCategory
    var conservation: ProductConservation
    var images: [ProductImage]
    private var distance: Int
    
    init() {
        id = -1
        title = ""
        description = ""
        status = .default
        category = ProductCategory()
        conservation = ProductConservation()
        images = []
        distance = 1
    }
    
    convenience init(dto: ProductDTO) {
        self.init()
        
        id << dto.id
        title << dto.title
        description << dto.description
        
        if let value = ProductStatus(rawValue: dto.status) {
            status = value
        }
        
        category = ProductCategory(dto: dto.category)
        
        // TO-DO
        // Tratar conservation
        images = dto.images.map{ ProductImage(dto: $0) }
        distance << dto.distance
        
    }
    
    // Get's
    func getId() -> Int { id }
    func getTitle() -> String { title }
    func getDescription() -> String { description }
    func getStatus() -> ProductStatus { status }
    func getDistance() -> Int { distance }
    
    
    // Set's
    func setId(_ value: Int) {
        id = value
    }
    func setTitle(_ value: String) {
        title = value
    }
    func setDescription(_ value: String) {
        description = value
    }
    func setStatus(_ value: ProductStatus) {
        status = value
    }
    func setDistance(_ value: Int) {
        distance = value
    }
    
}
