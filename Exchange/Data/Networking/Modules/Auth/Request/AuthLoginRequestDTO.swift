import Foundation


nonisolated
struct AuthLoginRequestDTO: Encodable, Sendable {
    let email: String
    let password: String
}
