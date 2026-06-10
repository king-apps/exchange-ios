//
//  RootWorker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 05/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class RootWorker {
   
    
    // Handler load
    func load(completion: @escaping(_ user: User) -> ()) {
        completion(User.shared)
    }
    
    
    // Handler controllers
    func controllers(completion: @escaping(_ list: [Root.RootController]) -> ()) {
        
        let list: [Root.RootController] = [
            .init(storyboard: "Match", title: "", icon: .layers),
            .init(storyboard: "Stickers", title: "", icon: .bookOpen),
            .init(storyboard: "Chat", title: "", icon: .messageCircle),
            .init(storyboard: "Profile", title: "", icon: .user),
            
           //    .init(storyboard: "MyProduct", title: "", icon: .grid),
            
            
        ]
        completion(list)
        
    }
    
    
    // Handler fcm token
    func fcmToken(completion: @escaping(_ error: String?) -> ()) {
        
        if let token = User.shared.getFcmToken() {
            let api = UserApi()
            api.fcmToken(request: .init(fcmToken: token)) { error in
                completion(error)
            }
        }
        else {
            completion(nil)
        }
        
    }
    
    
    // Handler user profile
    func userProfile(completion: @escaping(_ user: User?, _ error: String?) -> ()) {
        
        let api = UserApi()
        api.profile { user, error in
            completion(user, error)
        }
        
    }
    
    
    // Handler appstore review
    func appStoreReview(completion: @escaping(_ shouldRequestReview: Bool) -> ()) {
        let shouldRequestReview = AppStoreReviewService.shared.consumePendingReviewRequest()
        completion(shouldRequestReview)
    }
  
    
}
