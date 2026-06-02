import Foundation


nonisolated
struct MatchProductIntentionRequestDTO: Encodable, Sendable {
    let productId: Int
    let intention: Int
}
