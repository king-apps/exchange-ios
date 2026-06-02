//
//  ProfileEmailTokenWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 19/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ProfileEmailTokenWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(email: String?, token: String, completion: @escaping(_ error: String?) -> ()) {
        
        
        let userApi = UserApi()
        let request = UserLinkEmailValidateDTO(code: token)
        userApi.linkEmailValidate(request: request) { user, error in
            
            if let user = user {
                user.save()
                User.shared.load()
                
                Auth.shared.setAnonymous(false)
                Auth.shared.save()
                completion(nil)
            }
            else {
                completion(error)
            }
            
        }
     
    }
    
    
}
