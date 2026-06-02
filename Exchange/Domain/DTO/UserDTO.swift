nonisolated
struct UserDTO: Decodable {
    let id: Int?
    let name: String
    let email: String?
    let avatarUrl: String?
    let notificationMatch: Bool?
    let notificationMsg: Bool?
    let notificationSuperLike: Bool?
    let messagesNotViwed: Int?
}
