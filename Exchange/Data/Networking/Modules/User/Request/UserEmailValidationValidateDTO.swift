import Foundation


nonisolated
struct UserEmailValidationValidateDTO: Encodable, Sendable {
    let email: String
    let code: String
}
