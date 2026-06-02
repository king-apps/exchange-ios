import Foundation


class ProductImage {
    
    private var id: Int
    private var url: String
    
    init() {
        id = -1
        url = ""
    }
    
    convenience init(dto: ProductImageDTO) {
        self.init()
        
        id << dto.id
        url << dto.url

    }
    
    func getId() -> Int { id }
    func getUrl() -> String { url }
}
