import Foundation


nonisolated
struct UserLocalizationRequestDTO: Encodable, Sendable {
    let latitude: Double
    let longitude: Double
}
