import Foundation


nonisolated
struct MatchChatMessagesRequestDTO: Encodable, Sendable {
    let id: Int
    let messageLastId: Int?
}
