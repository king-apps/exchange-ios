import Foundation


nonisolated
struct UserUpdateRequestDTO: Encodable, Sendable {
    let name: String
    let notificationMatch: Bool
    let notificationMsg: Bool
}
