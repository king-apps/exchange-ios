import Foundation

typealias MatchChatMessagesResponseDTO = [MatchChatMessageResponseDTO]

nonisolated
struct MatchChatMessageResponseDTO: Decodable, Sendable {
    let id: Int
    let type: String
    let text: String
    let creationDate: String
}
