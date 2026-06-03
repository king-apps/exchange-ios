import Foundation


extension Notification.Name {
    
    static let reloadMatchMaker = Notification.Name("kNotificationReloadMatchMaker")
    static let reloadProductList = Notification.Name("kNotificationReloadProductList")
    static let reloadChatList = Notification.Name("kNotificationReloadChatList")
    static let reloadChatListBadge = Notification.Name("kNotificationReloadChatListBadge")
    static let reloadProfile = Notification.Name("kNotificationReloadProfile")
    
    static let reloadFilterList = Notification.Name("kNotificationReloadFilterList")
    static let updateFcmToken = Notification.Name("kNotificationUpdateFcmToken")
}
