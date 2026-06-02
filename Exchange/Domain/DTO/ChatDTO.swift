nonisolated
struct ChatDTO: Decodable {
    let id: Int?
    let distance: Int?
    let status: String?
    
    let chatId: Int?
    let lastMessage: String?
    let avatarUrl: String?
    let notViewed: Int?
    let type: String?
    let name: String?
}
