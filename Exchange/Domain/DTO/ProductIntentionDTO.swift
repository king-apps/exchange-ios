import Foundation


nonisolated
struct ProductIntentionDTO: Decodable, Sendable {
    let match: Bool
    let chat: ChatDTO?
    let yourLikedProducts: [ProductDTO]?
    let hisLikedProducts: [ProductDTO]?
    let productOwner: ProductOwnerDTO?
}
