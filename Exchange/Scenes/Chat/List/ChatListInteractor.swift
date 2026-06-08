//
//  ChatListInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatListBusinessLogic {
    func load(request: ChatList.Load.Request)
    func fetch(request: ChatList.Fetch.Request)
    func save(request: ChatList.Save.Request)
    func delete(request: ChatList.Delete.Request)
}


protocol ChatListDataStore {
    var chat: Chat? { get }
}


class ChatListInteractor: ChatListBusinessLogic, ChatListDataStore {
    
    
    // Var's
    var presenter: ChatListPresentationLogic?
    var worker = ChatListWorker()
    
    var chat: Chat?
    var chats: [Chat]?
  
    
    // Handler load
    func load(request: ChatList.Load.Request) {
        
        worker.load {
            let response = ChatList.Load.Response(height: request.height)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fecth
    func fetch(request: ChatList.Fetch.Request) {
        
        worker.fetch { chats, error, showAds in
            
            // Store in memory
            self.chats = chats
            
            let response = ChatList.Fetch.Response(
                chats: chats,
                error: error,
                showAds: showAds
            )
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: ChatList.Save.Request) {
        
        worker.save(chatId: request.chatId, chats: self.chats) { chat in
            
            // Store in memory
            self.chat = chat
            
            let response = ChatList.Save.Response()
            self.presenter?.save(response: response)
        }
    }
    
    
    // Handler delete
    func delete(request: ChatList.Delete.Request) {
        
        worker.delete(chatId: request.chatId) { error in
            let response = ChatList.Delete.Response(error: error)
            self.presenter?.delete(response: response)
        }
        
    }
    
    
}
