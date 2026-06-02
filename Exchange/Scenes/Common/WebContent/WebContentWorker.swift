//
//  WebContentWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 21/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class WebContentWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(url: String, completion: @escaping(_ url: URL?, _ error: String?) -> ()) {
        
        if let url = url.normalizedURL() {
            completion(url, nil)
            return
        }
        completion(nil, "URL não configurada.")
        
    }
    
}
