import Foundation


nonisolated
struct ProductBoostResponseDTO: Decodable, Sendable {
    let expiresAt: String
    let active: Bool
    let remainingMinutes: Int
}
