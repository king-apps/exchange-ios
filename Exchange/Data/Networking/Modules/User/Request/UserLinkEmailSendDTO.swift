import Foundation


nonisolated
struct UserLinkEmailSendDTO: Encodable, Sendable {
    let name: String
    let email: String
}
