import UIKit
import UserNotifications


class AuthNotificationWorker {
    
    private func dispatchToMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        }
        else {
            DispatchQueue.main.async(execute: block)
        }
    }
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        dispatchToMain {
            completion()
        }
    }
    
    
    // Handler notification
    func notification(completion: @escaping(_ granted: Bool) -> ()) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let _ = error {
                self.dispatchToMain {
                    completion(false)
                }
            }
            else {
                if granted {
                    self.dispatchToMain {
                        UIApplication.shared.registerForRemoteNotifications()
                        completion(true)
                    }
                }
                else {
                    self.dispatchToMain {
                        completion(false)
                    }
                }
            }
        }
        
    }
    
    
    // Hanlder save
    func save(granted: Bool, completion: @escaping() -> ()) {
        
        
        dispatchToMain {
            completion()
        }
    }
    
}
