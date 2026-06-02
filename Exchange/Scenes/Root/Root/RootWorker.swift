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
  
    
}
