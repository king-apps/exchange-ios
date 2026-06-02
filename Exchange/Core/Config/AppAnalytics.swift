import Foundation

final class AppAnalytics {
    static let shared = AppAnalytics()

    enum Event {
        case authHomeViewed
        case authInputEmailViewed
        case authInputTokenViewed
        case authNotificationViewed
        case authSelectCourseViewed
        case authSuccessViewed
        case authTrackingViewed
    }

    private init() {}

    func log(_ event: Event) {}

    func logEvent(_ name: String, parameters: [String: Any]?) {}
}
