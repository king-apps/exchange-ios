import Foundation


nonisolated
struct UserEmailValidationSendDTO: Encodable, Sendable {
    let name: String
    let email: String
}
