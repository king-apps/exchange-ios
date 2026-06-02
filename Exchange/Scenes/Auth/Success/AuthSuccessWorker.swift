//
//  AuthSuccessWorker.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 02/12/25.
//  Copyright (c) 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class AuthSuccessWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(completion: @escaping() -> ()) {
        
        Auth.shared.save()
        completion()
        
    }
    
    
}
