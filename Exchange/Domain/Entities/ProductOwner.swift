import Foundation


class ProductOwner {
    
    private var name: String
    private var email: String
    
    init() {
        name = ""
        email = ""
    }
    
    convenience init(dto: ProductOwnerDTO) {
        self.init()
        
        name << dto.name
        email << dto.email

    }
    
    func getName() -> String { name }
    func getEmail() -> String { email }
    
}
