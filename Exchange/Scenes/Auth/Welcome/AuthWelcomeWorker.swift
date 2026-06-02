//
//  AuthWelcomeWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 11/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class AuthWelcomeWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler email
    func email(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler skip
    func skip(completion: @escaping(_ error: String?) -> ()) {
        
        // Caso o usuario clique em voltar e prosseguir nao cria um novo usuario anonimo
        if Auth.shared.isAuth() {
            completion(nil)
            return
        }
        
        let api = AuthApi()
        api.loginAnonymous { auth, error in
            auth?.save()
            Auth.shared.load()
            
            let userApi = UserApi()
            userApi.profile { user, error in
                user?.save()
                User.shared.load()
                
                // Custom
                if let _ = user {
                    
                    let service = StickerService()
                    service.createDefaultsIfNeeded { success in
                        if success {
                            completion(nil)
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
    
    
}
