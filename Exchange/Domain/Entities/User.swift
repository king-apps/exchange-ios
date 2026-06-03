import Foundation


class User {
    
    
    // Var's
    public static let shared = User()
    private var id: Int
    private var name: String
    private var email: String
    private var avatarUrl: String
    private var notificationMatch: Bool
    private var notificationMessage: Bool
    private var notificationSuperLike: Bool
    private var messagesNotViewed: Int
    
    private var needUpdateAvatar: Bool
    private var boostRemainingMinutes: Int?
    
    private var fcmToken: String?
  
    
    
    // Keys
    private enum Key {
        static let id = "User.Id"
        static let name = "User.Name"
        static let email = "User.Email"
        static let avatarUrl = "User.AvatarUrl"
        static let notificationMatch = "User.NotificationMatch"
        static let notificationMessage = "User.NotificationMessage"
        static let notificationSuperLike = "User.NotificationSuperLike"
        static let messagesNotViewed = "User.MessagesNotViewed"
    }
    
    
    // Construct
    init() {
        self.id = -1
        self.name = ""
        self.email = ""
        self.avatarUrl = ""
        self.notificationMatch = true
        self.notificationMessage = true
        self.notificationSuperLike = true
        self.messagesNotViewed = 0
        needUpdateAvatar = false
    }
    convenience init(dto: UserDTO) {
        self.init()
        
        id << dto.id
        id << dto.userId
        name << dto.name
        email << dto.email
        avatarUrl << dto.avatarUrl
        notificationMatch << dto.notificationMatch
        notificationMessage << dto.notificationMsg
        notificationSuperLike << dto.notificationSuperLike
        messagesNotViewed << dto.messagesNotViewed
    }
    
    
    // Save
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.id, forKey: Key.id)
        defaults.set(self.name, forKey: Key.name)
        defaults.set(self.email, forKey: Key.email)
        defaults.set(self.avatarUrl, forKey: Key.avatarUrl)
        defaults.set(self.notificationMatch, forKey: Key.notificationMatch)
        defaults.set(self.notificationMessage, forKey: Key.notificationMessage)
        defaults.set(self.notificationSuperLike, forKey: Key.notificationSuperLike)
        defaults.set(self.messagesNotViewed, forKey: Key.messagesNotViewed)
        defaults.synchronize()
    }
    
    
    // Load
    func load() {
        let defaults = UserDefaults.standard
        self.id << defaults.value(forKey: Key.id)
        self.name << defaults.value(forKey: Key.name)
        self.email << defaults.value(forKey: Key.email)
        self.avatarUrl << defaults.value(forKey: Key.avatarUrl)
        self.notificationMatch << defaults.value(forKey: Key.notificationMatch)
        self.notificationMessage << defaults.value(forKey: Key.notificationMessage)
        self.notificationSuperLike << defaults.value(forKey: Key.notificationSuperLike)
        self.messagesNotViewed << defaults.value(forKey: Key.messagesNotViewed)
    }
    
    // Clear
    func clear() {
        self.id = -1
        self.name = ""
        self.email = ""
        self.avatarUrl = ""
        self.notificationMatch = true
        self.notificationMessage = true
        self.notificationSuperLike = true
        self.messagesNotViewed = 0
        save()
    }
    
    
    // Get's
    func getId() -> Int {
        return self.id
    }
    func getName() -> String {
        return self.name
    }
    func getEmail() -> String {
        return self.email
    }
    func getAvatarUrl() -> String {
        return self.avatarUrl
    }
    func getNotificationMatch() -> Bool {
        return self.notificationMatch
    }
    func getNotificationMessage() -> Bool {
        return self.notificationMessage
    }
    func getNotificationSuperLike() -> Bool {
        return self.notificationSuperLike
    }
    func getMessagesNotViewed() -> Int {
        return self.messagesNotViewed
    }
    func getNeedUpdateAvatar() -> Bool {
        return self.needUpdateAvatar
    }
    func getBoostProfileIsActive() -> Bool {
        let time = boostRemainingMinutes ?? 0
        return time > 0
    }
    func getBoostRemainingMinutes() -> Int {
        return boostRemainingMinutes ?? 0
    }
    func getFcmToken() -> String? {
        return fcmToken
    }
    
    // Set's
    func setNeedUpdateAvatar(_ value: Bool) {
        self.needUpdateAvatar = value
    }
    func setBoostRemainingMinutes(_ value: Int?) {
        self.boostRemainingMinutes = value
    }
    func setFcmToken(_ value: String) {
        self.fcmToken = value
    }
     
}
