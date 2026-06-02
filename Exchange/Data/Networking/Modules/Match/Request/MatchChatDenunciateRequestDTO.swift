import Foundation


nonisolated
struct MatchChatDenunciateRequestDTO: Encodable, Sendable {
    let chatId: Int
    let reason: String
}
