import Foundation


nonisolated
struct ProductSaveRequestDTO: Encodable, Sendable {
    let title: String
    let categoryId: Int
    let images: [Data]
}
