//
//  IntroInteractor.swift
//  exchange
//
//  Created by Douglas Cicarello on 27/04/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol IntroBusinessLogic {
    func load(request: Intro.Load.Request)
    func language(request: Intro.Language.Request)
    func remote(request: Intro.Remote.Request)
    func auth(request: Intro.Auth.Request)
    func redirect(request: Intro.Redirect.Request)
}


protocol IntroDataStore {
    
}


class IntroInteractor: IntroBusinessLogic, IntroDataStore {
    
    
    // Var's
    var presenter: IntroPresentationLogic?
    var worker = IntroWorker()
  
    
    // Handler load
    func load(request: Intro.Load.Request) {
        
        worker.load {
            let response = Intro.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler language
    func language(request: Intro.Language.Request) {
        
        worker.language { language in
            let response = Intro.Language.Response(language: language)
            self.presenter?.language(response: response)
        }
        
    }
    
    
    // Handler remote
    func remote(request: Intro.Remote.Request) {
        
        worker.remote {
            let response = Intro.Remote.Response()
            self.presenter?.remote(response: response)
        }
        
    }
    
    
    // Handler auth
    func auth(request: Intro.Auth.Request) {
        
        worker.auth {
            let response = Intro.Auth.Response()
            self.presenter?.auth(response: response)
        }
        
    }
    
    
    // Handler redirect
    func redirect(request: Intro.Redirect.Request) {
        
        worker.redirect { isAuth in
            let response = Intro.Redirect.Response(isAuth: isAuth)
            self.presenter?.redirect(response: response)
        }
        
    }
 
    
}
