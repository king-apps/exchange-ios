//
//  AuthTrackingWorker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 13/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AppTrackingTransparency


class AuthTrackingWorker {
    
    
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
    
    
    // Handler tracking
    func tracking(completion: @escaping(_ granted: Bool) -> ()) {
        dispatchToMain {
            guard #available(iOS 14, *) else {
                completion(true)
                return
            }
            
            let status = ATTrackingManager.trackingAuthorizationStatus
            
            switch status {
            case .authorized:
                completion(true)
            case .denied, .restricted:
                completion(false)
            case .notDetermined:
                ATTrackingManager.requestTrackingAuthorization { status in
                    self.dispatchToMain {
                        completion(status == .authorized)
                    }
                }
            @unknown default:
                completion(false)
            }
        }
    }
    
    
    // Handler save
    func save(granted: Bool, completion: @escaping() ->()) {
        dispatchToMain {
            completion()
        }
    }
    
}
