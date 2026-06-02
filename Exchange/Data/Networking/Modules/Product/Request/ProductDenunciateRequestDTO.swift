import Foundation


nonisolated
struct ProductDenunciateRequestDTO: Encodable, Sendable {
    let productId: Int
    let reason: String
}
