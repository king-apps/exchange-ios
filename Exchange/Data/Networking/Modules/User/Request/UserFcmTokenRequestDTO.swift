import Foundation


nonisolated
struct UserFcmTokenRequestDTO: Encodable, Sendable {
    let fcmToken: String
}
