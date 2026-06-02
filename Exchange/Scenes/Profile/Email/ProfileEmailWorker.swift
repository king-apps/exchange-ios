//
//  ProfileEmailWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ProfileEmailWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(email: String, completion: @escaping(_ error: String?) -> ()) {
        
        let api = UserApi()
        let request = UserLinkEmailSendDTO(name: "", email: email)
        api.linkEmailSend(request: request) { error in
            completion(error)
        }
        
    }
    
}
