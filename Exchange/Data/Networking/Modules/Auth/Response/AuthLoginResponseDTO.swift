import Foundation


nonisolated
struct AuthLoginResponseDTO: Decodable, Sendable {
    let id: Int
    let name: String?
    let email: String
    let token: String
    let anonymous: Bool?
}
