import Foundation


nonisolated
struct AuthAccessCodeRequestDTO: Encodable, Sendable {
    let name: String?
    let email: String
}
