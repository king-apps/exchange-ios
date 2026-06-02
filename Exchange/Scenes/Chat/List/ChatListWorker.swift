//
//  ChatListWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


class ChatListWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler fetch
    func fetch(completion: @escaping(_ chats: [Chat]?, _ error: String?) -> ()) {
        
        let api = MatchApi()
        api.chat { chats, error in
            completion(chats, error)
        }
        
    }
    
    
    // Handler save
    func save(chatId: Int, chats: [Chat]?, completion: @escaping(_ chat: Chat?) -> ()) {
    
        let chat = chats?.first(where: {$0.getId() == chatId})
        completion(chat)
        
    }
    
    
    // Handler delete
    func delete(chatId: Int, completion: @escaping(_ error: String?) -> ()) {
        
        let api = MatchApi()
        api.chatDelete(request: .init(id: chatId)) { error in
            completion(error)
        }
        
    }
    
    
}
