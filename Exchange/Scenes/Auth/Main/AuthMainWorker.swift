//
//  AuthMainWorker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 26/11/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class AuthMainWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler page control
    func pageControl(completion: @escaping(_ auth: Auth) -> ()) {
        
        let auth = Auth.shared
        completion(auth)
        
    }
    
    
}
