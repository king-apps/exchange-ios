import Foundation


class ProductConservation {
    
    private var id: Int
    private var description: String
    
    init() {
        id = -1
        description = ""
    }
    
    convenience init(json: [String: Any]) {
        self.init()
        id << json["id"]
        description << json["description"]
    }
    
    func getId() -> Int { id }
    func getDescription() -> String { description }
}
