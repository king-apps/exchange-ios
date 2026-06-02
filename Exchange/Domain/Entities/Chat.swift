import Foundation


class Chat {
    
    private var id: Int
    private var name: String
    private var avatarUrl: String
    private var lastMessage: String
    private var notViewed: Int
    private var distance: Int
    private var type: ChatType
    
    enum ChatType: String {
        case match = "MATCH"
        case superlike = "SUPERLIKE"
    }
    
    init() {
        id = -1
        name = ""
        avatarUrl = ""
        lastMessage = ""
        notViewed = 0
        distance = 0
        type = .match
    }
    convenience init(dto: ChatDTO) {
        self.init()
        
        id << dto.id
        id << dto.chatId
        
        name << dto.name
        avatarUrl << dto.avatarUrl
        lastMessage << dto.lastMessage
        notViewed << dto.notViewed
        distance << dto.distance
        
        if let raw = dto.type, let value = ChatType(rawValue: raw) {
            type = value
        }
    }
    convenience init(json: [String: Any]) {
        self.init()
        id << json["chatId"]
        name << json["name"]
        avatarUrl << json["avatarUrl"]
        lastMessage << json["lastMessage"]
        notViewed << json["notViewed"]
        distance << json["distance"]
        if let typeString = json["type"] as? String {
            type = .init(rawValue: typeString) ?? .match
        } else {
            type = .match
        }
    }
    
    func getId() -> Int { id }
    func getName() -> String { name }
    func getAvatarUrl() -> String { avatarUrl }
    func getLastMessage() -> String { lastMessage }
    func getNotViewed() -> Int { notViewed }
    func getDistance() -> Int { distance }
    func getType() -> ChatType {
        return type
    }
    
}
