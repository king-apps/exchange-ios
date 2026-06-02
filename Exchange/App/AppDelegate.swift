//
//  AppDelegate.swift
//  exchange
//
//  Created by Douglas Cicarello on 25/04/26.
//

import UIKit
import Foundation
import KingOS
import GoogleMobileAds
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // Ads
        if !AppEnvironment.adAppId.isEmpty {
            MobileAds.shared.start()
            MobileAds.shared.requestConfiguration.testDeviceIdentifiers = [
                ""
            ]
        }
        
        // Firebase
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            if let options = FirebaseOptions(contentsOfFile: path) {
                FirebaseApp.configure(options: options)
            }
            else {
                FirebaseApp.configure()
            }
        }
        Messaging.messaging().delegate = self

        
        // Notification
        UNUserNotificationCenter.current().delegate = self
        registerForRemoteNotificationsIfAuthorized(application)
        
        
        // Store
        InAppPurchase.shared.start()
    
        
        // King OS
        KingOS.configure(
            configuration: .init(
                baseURL: "https://os.king.app.br",
                apiKey: "f8429d113325824cd53dc287f263f2470bf0ef3855bf0bd0",
                appSlug: AppEnvironment.appKey
            ),
            options: .init(
                debug: true,
                autoload: true
            )
        )
        
        
        // Enable keyboard management
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        
        
        return true
    }
    
    
    private func registerForRemoteNotificationsIfAuthorized(_ application: UIApplication) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let authorizedStatuses: [UNAuthorizationStatus] = [.authorized, .provisional, .ephemeral]
            guard authorizedStatuses.contains(settings.authorizationStatus) else {
                return
            }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "MainScene", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
