//
//  WebContentInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol WebContentBusinessLogic {
    func load(request: WebContent.Load.Request)
    func fetch(request: WebContent.Fetch.Request)
}


protocol WebContentDataStore {
    var url: String { get set }
}


class WebContentInteractor: WebContentBusinessLogic, WebContentDataStore {
    
    
    // Var's
    var presenter: WebContentPresentationLogic?
    var worker = WebContentWorker()
    
    var url: String = ""
  
    
    // Handler load
    func load(request: WebContent.Load.Request) {
        
        worker.load {
            let response = WebContent.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: WebContent.Fetch.Request) {
        
        worker.fetch(url: self.url) { url, error in
            let response = WebContent.Fetch.Response(url: url, error: error)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
}
