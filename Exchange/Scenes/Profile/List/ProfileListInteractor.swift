//
//  ProfileListInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 18/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ProfileListBusinessLogic {
    func load(request: ProfileList.Load.Request)
    func boostStatus(request: ProfileList.BoostStatus.Request)
    func fetch(request: ProfileList.Fetch.Request)
    func save(request: ProfileList.Save.Request)
    func deleteAccount(request: ProfileList.DeleteAccount.Request)
    func logout(request: ProfileList.Logout.Request)
    func avatar(request: ProfileList.Avatar.Request)
}


protocol ProfileListDataStore {
    
}


class ProfileListInteractor: ProfileListBusinessLogic, ProfileListDataStore {
    
    
    // Var's
    var presenter: ProfileListPresentationLogic?
    var worker = ProfileListWorker()
  
    
    // Handler load
    func load(request: ProfileList.Load.Request) {
        
        worker.load {
            let response = ProfileList.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Boost Status
    func boostStatus(request: ProfileList.BoostStatus.Request) {
        
        worker.boostStatus {
            let response = ProfileList.BoostStatus.Response()
            self.presenter?.boostStatus(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: ProfileList.Fetch.Request) {
        
        worker.fetch { auth, user, remote, showAds in
            let response = ProfileList.Fetch.Response(
                auth: auth,
                user: user,
                remote: remote,
                showAds: showAds
            )
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: ProfileList.Save.Request) {
        
        worker.save(request: request) { error in
            let response = ProfileList.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
        
    }
    
    
    // Handler delete account
    func deleteAccount(request: ProfileList.DeleteAccount.Request) {
        
        worker.deleteAccount { error in
            let response = ProfileList.DeleteAccount.Response(error: error)
            self.presenter?.deleteAccount(response: response)
        }
        
    }
    
    
    // Handler logout
    func logout(request: ProfileList.Logout.Request) {
        
        worker.logout {
            let response = ProfileList.Logout.Response()
            self.presenter?.logout(response: response)
        }
        
    }
    
    
    // Handler avatar
    func avatar(request: ProfileList.Avatar.Request) {
        
        worker.avatar(image: request.image) { error in
            let response = ProfileList.Avatar.Response(error: error)
            self.presenter?.avatar(response: response)
        }
        
    }
    
    
}
