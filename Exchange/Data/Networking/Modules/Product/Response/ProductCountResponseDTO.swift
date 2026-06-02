import Foundation


nonisolated
struct ProductCountResponseDTO: Decodable, Sendable {
    let myProducts: Int
}
