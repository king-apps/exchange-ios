import Foundation


class ProductIntention {
    
    var yourLikedProducts: [Product]
    var hisLikedProducts: [Product]
    var productOwner: ProductOwner
    var chat: Chat
    var match: Bool
    
    init() {
        yourLikedProducts = []
        hisLikedProducts = []
        productOwner = ProductOwner()
        chat = Chat()
        match = false
    }
    convenience init(dto: ProductIntentionDTO) {
        self.init()
        
        match << dto.match
        if let products = dto.yourLikedProducts {
            yourLikedProducts = products.map{ Product(dto: $0) }
        }
        if let products = dto.hisLikedProducts {
            hisLikedProducts = products.map{ Product(dto: $0) }
        }
        if let owner = dto.productOwner {
            productOwner = ProductOwner(dto: owner)
        }
        if let chatDTO = dto.chat {
            chat = Chat(dto: chatDTO)
        }
        
    }
    
    func getMatch() -> Bool { match }
}
