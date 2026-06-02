import Foundation

typealias MatchChatProductsResponseDTO = [MatchChatProductResponseDTO]

nonisolated
struct MatchChatProductResponseDTO: Decodable, Sendable {
    let user: UserDTO
    let product: ProductDTO
}
