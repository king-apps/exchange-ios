import Foundation


nonisolated
struct UserLinkEmailValidateDTO: Encodable, Sendable {
    let code: String
}
