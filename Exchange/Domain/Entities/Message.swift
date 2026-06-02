import Foundation


enum MessageType: String {
    case app = "APP"
    case he = "HE"
    case me = "ME"
}


class Message {
    
    private var id: Int
    private var text: String
    private var creationDate: String
    private var type: MessageType
    
    init() {
        id = -1
        text = ""
        creationDate = ""
        
        type = .app
    }
    
    convenience init(json: [String: Any]) {
        self.init()
        id << json["id"]
        text << json["text"]
        creationDate << json["creationDate"]
        if let rawValue = json["type"] as? String, let type = MessageType(rawValue: rawValue) {
            self.type = type
        }
    }
    convenience init(dto: MatchChatMessageResponseDTO) {
        self.init()
        id << dto.id
        text << dto.text
        creationDate << dto.creationDate
        if let type = MessageType(rawValue: dto.type) {
            self.type = type
        }
    }
    
    func getId() -> Int { id }
    func getText() -> String { text }
    func getCreationDate() -> String { creationDate }
    
    func getCreationDateForHuman() -> String {
        guard let date = parseCreationDate() else {
            return ""
        }
        
        let calendar = Calendar.current
        let time = format(date: date, formatKey: "Chat.Message.Date.Format.Time")
        
        if calendar.isDateInToday(date) {
            return "Chat.Message.Date.Today".localized.replacingOccurrences(of: "{$0}", with: time)
        }
        
        if calendar.isDateInYesterday(date) {
            return "Chat.Message.Date.Yesterday".localized.replacingOccurrences(of: "{$0}", with: time)
        }
        
        let dateText = format(date: date, formatKey: "Chat.Message.Date.Format.Date")
        return "Chat.Message.Date.Full".localized
            .replacingOccurrences(of: "{$0}", with: dateText)
            .replacingOccurrences(of: "{$1}", with: time)
    }
    
    func getType() -> MessageType { type }
    
    private func parseCreationDate() -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: creationDate) {
            return date
        }
        
        isoFormatter.formatOptions = [.withInternetDateTime]
        if let date = isoFormatter.date(from: creationDate) {
            return date
        }
        
        let fallbackFormatter = DateFormatter()
        fallbackFormatter.locale = Locale(identifier: "en_US_POSIX")
        fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return fallbackFormatter.date(from: creationDate)
    }
    
    private func format(date: Date, formatKey: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: AppEnvironment.language == "pt" ? "pt_BR" : "en_US")
        formatter.dateFormat = formatKey.localized
        return formatter.string(from: date)
    }
}
