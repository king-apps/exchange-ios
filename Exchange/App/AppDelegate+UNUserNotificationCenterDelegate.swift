//
//  AppDelegate+UNUserNotificationCenterDelegate.swift
//  Demo
//
//  Created by Douglas Cicarello on 01/12/25.
//
import NotificationCenter
import FirebaseMessaging


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        #if DEBUG
        print("APNS token registered")
        #endif
        Messaging.messaging().token { token, error in
            if let error {
                #if DEBUG
                print("Failed to fetch FCM token: \(error.localizedDescription)")
                #endif
                return
            }
            
            if let token {
                self.updateFcmTokenIfPossible(token)
            }
        }
        subscribeToAppTopicIfPossible()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        #if DEBUG
        print("Failed to register for remote notifications: \(error.localizedDescription)")
        #endif
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        NotificationCenter.default.post(name: .reloadChatList, object: nil)
        NotificationCenter.default.post(name: .reloadChatListBadge, object: nil)
        // TO-DO caso precise mostrar push com o app aberto, so descomentar essa linha
        // completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // TO-DO
        // Deeplink (tratar aqui os parametros de abertura de notificacao)
        completionHandler()
    }
    
    
}
