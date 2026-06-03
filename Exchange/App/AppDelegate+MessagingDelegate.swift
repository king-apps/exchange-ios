import FirebaseMessaging


extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let fcmToken = fcmToken {
            updateFcmTokenIfPossible(fcmToken)
        }

        subscribeToAppTopicIfPossible()
        
    }
    func subscribe(toTopic: String) {
        Messaging.messaging().subscribe(toTopic: toTopic) { error in
            if let error {
                print("Failed to subscribe to topic \(toTopic): \(error.localizedDescription)")
                return
            }
        }
    }
    func unsubscribe(fromTopic: String) {
        Messaging.messaging().unsubscribe(fromTopic: fromTopic)
    }
    func subscribeToAppTopicIfPossible() {
        guard Messaging.messaging().apnsToken != nil else {
            print("Skipping topic subscription until APNS token is available")
            return
        }
        
        let topic = "ex_\(AppEnvironment.appId)"
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !topic.isEmpty else {
            assertionFailure("EX_APP_KEY must not be empty")
            return
        }
        
        subscribe(toTopic: topic)
    }
    func updateFcmTokenIfPossible(_ fcmToken: String) {
        let sanitizedToken = fcmToken.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !sanitizedToken.isEmpty else {
            #if DEBUG
            print("Skipping FCM token update because token is empty")
            #endif
            return
        }
        print("🔥 FCM Token:", sanitizedToken)
        
        User.shared.setFcmToken(sanitizedToken)
        NotificationCenter.default.post(name: .updateFcmToken, object: nil)
    }
    
}
