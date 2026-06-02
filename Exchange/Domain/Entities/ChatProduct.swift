import Foundation


class ChatProduct {
    
    var user: User
    var product: Product
    
    init() {
        user = User()
        product = Product()
    }
    
    convenience init(dto: MatchChatProductResponseDTO) {
        self.init()
        
        user = User(dto: dto.user)
        product = Product(dto: dto.product)
        
    }
}
