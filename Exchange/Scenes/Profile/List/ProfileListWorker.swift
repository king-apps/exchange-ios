//
//  ProfileListWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ProfileListWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Boost Status
    func boostStatus(completion: @escaping() -> ()) {
        
        let api = ProductApi()
        api.boostStatus { remainingMinutes, error in
            User.shared.setBoostRemainingMinutes(remainingMinutes)
            completion()
        }
      
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ auth: Auth, _ user: User, _ remote: RemoteConfig) -> ()) {
        
        let auth = Auth.shared
        let user = User.shared
        let remote = RemoteConfig.shared
        completion(auth, user, remote)
        
    }
    
    
    // Handler save
    func save(request: ProfileList.Save.Request, completion: @escaping(_ error: String?) -> ()) {
        
        let requestDTO = UserUpdateRequestDTO(
            name: User.shared.getName(),
            notificationMatch: request.notificationMatch,
            notificationMsg: request.notificationMessage
        )
        
        let api = UserApi()
        api.update(request: requestDTO) { user, error in
            user?.save()
            User.shared.load()
            completion(error)
        }
        
    }
    
    
    // Handler delete account
    func deleteAccount(completion: @escaping(_ error: String?) -> ()) {
        
        let api = UserApi()
        api.delete { error in
            self.clearLocalUserData()
            completion(error)
        }
        
    }
    
    
    // Logout
    func logout(completion: @escaping() -> ()) {
        
        clearLocalUserData()
        completion()
        
    }
    
    private func clearLocalUserData() {
        Auth.shared.clear()
        User.shared.clear()
        LocalConfig.shared.clear()
        
        do {
            try StickerDatabase().clearUserData()
        }
        catch {
            print("[ProfileListWorker] Failed to clear sticker user data: \(error.localizedDescription)")
        }
    }
    
    
    // Handler avatar
    func avatar(image: UIImage, completion: @escaping(_ error: String?) -> ()) {
        
        let resize = CGSizeMake(
            CGFloat(RemoteConfig.shared.getProductImageMaxWidth()),
            CGFloat(RemoteConfig.shared.getProductImageMaxHeight())
        )
        if let data = image.resize(to: resize)?.pngData() {
            let api = UserApi()
            let request = UserAvatarRequestDTO(data: data)
            api.avatar(request: request) { user, error in
                if let user = user {
                    user.save()
                    User.shared.load()
                    User.shared.setNeedUpdateAvatar(true)
                }
                completion(error)
            }
        }
    }
    
    
}
