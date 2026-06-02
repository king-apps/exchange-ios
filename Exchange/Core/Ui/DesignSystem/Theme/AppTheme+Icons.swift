import UIKit


extension AppTheme {

    enum Icon: String {
        case arrowUp = "arrow_up"
        case arrowRight = "arrow_right"
        case arrowDown = "arrow_down"
        case arrowLeft = "arrow_left"
        case alertCircle = "alert_circle"
        case atSign = "at_sign"
        case award = "award"
        case barChart = "bar_chart"
        case bell = "bell"
        case bookOpen = "book_open"
        case calendar = "calendar"
        case camera = "camera"
        case cardsLiked = "cards_liked"
        case checkCircle = "check_circle"
        case check = "check"
        case circle = "circle"
        case clock = "clock"
        case coffee = "coffee"
        case creditCard = "credit_card"
        case download = "download"
        case droplet = "droplet"
        case edit3 = "edit_3"
        case eye = "eye"
        case fileText = "file_text"
        case filter = "filter"
        case flag = "flag"
        case frown = "frown"
        case grid = "grid"
        case heart = "heart"
        case heartFill = "heart_fill"
        case home = "home"
        case instagram = "instagram"
        case layers = "layers"
        case like = "like"
        case likeFill = "like_fill"
        case link = "link"
        case lock = "lock"
        case logout = "logout"
        case mail = "mail"
        case mapPin = "map_pin"
        case messageCircle = "message_circle"
        case percent = "percent"
        case pieChart = "pie_chart"
        case plus = "plus"
        case rocket = "rocket"
        case rotateCcw = "rotate_ccw"
        case share = "share"
        case sliders = "sliders"
        case star = "star"
        case starFill = "star_fill"
        case tag = "tag"
        case trash = "trash"
        case unlock = "unlock"
        case uploadCloud = "upload_cloud"
        case user = "user"
        case video = "video"
        case x = "x"
        case phone = "phone"
        case none = ""
        case helpCircle = "help_circle"
        case custom
    }

    private static var _iconCache: [String: UIImage] = [:]
    private static let _iconCacheLock = NSLock()

    static func icon(_ token: Icon, fallback: UIImage = UIImage(), file: StaticString = #fileID, line: UInt = #line) -> UIImage {

        guard token != .none, token.rawValue.isEmpty == false else { return UIImage() }

        _iconCacheLock.lock()
        defer { _iconCacheLock.unlock() }

        if let cached = _iconCache[token.rawValue] {
            return cached
        }

        let resolved = UIImage(named: token.rawValue) ?? {
            assertionFailure("🧩 Missing icon asset: \(token.rawValue) (\(file):\(line))")
            return fallback
        }()

        _iconCache[token.rawValue] = resolved
        return resolved
    }
}
