//
//  AuthInputTokenWorker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 03/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class AuthInputTokenWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(email: String?, token: String, completion: @escaping(_ error: String?) -> ()) {
       
        let email = email ?? ""
        let request = AuthLoginRequestDTO(email: email, password: token)
        
        let api = AuthApi()
        api.login(request: request) { auth, error in
            auth?.save()
            Auth.shared.load()
            
            // Custom
            if let _ = auth {
                let service = StickerService()
                service.createDefaultsIfNeeded { success in
                    if success {
                        
                        let userApi = UserApi()
                        userApi.profile { user, error in
                            user?.save()
                            User.shared.load()
                            completion(error)
                        }
        
                    }
                    else {
                        completion("Error.500".localized)
                    }
                }
            }
            else {
                completion(error)
            }
        }
    
    }
    
    
}
