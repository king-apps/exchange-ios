import Foundation


nonisolated
struct MatchSearchRequestDTO: Encodable, Sendable {
    let radius: Int
    let categories: [Int]
    let page: Int
}
