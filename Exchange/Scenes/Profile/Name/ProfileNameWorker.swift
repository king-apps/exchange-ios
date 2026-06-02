//
//  ProfileNameWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 22/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ProfileNameWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(name: String, completion: @escaping(_ error: String?) -> ()) {
        
        let request = UserUpdateRequestDTO(
            name: name,
            notificationMatch: User.shared.getNotificationMatch(),
            notificationMsg: User.shared.getNotificationMessage()
        )
        let api = UserApi()
        api.update(request: request) { user, error in
            if let user = user {
                user.save()
                User.shared.load()
            }
            completion(error)
        }
        
    }
    
    
}
