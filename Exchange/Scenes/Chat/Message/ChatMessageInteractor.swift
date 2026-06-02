//
//  ChatMessageInteractor.swift
//  Exchange
//
//  Created by Douglas Cicarello on 15/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatMessageBusinessLogic {
    func load(request: ChatMessage.Load.Request)
    func fetch(request: ChatMessage.Fetch.Request)
    func send(request: ChatMessage.Send.Request)
}


protocol ChatMessageDataStore {
    var chat: Chat? { get set }
}


class ChatMessageInteractor: ChatMessageBusinessLogic, ChatMessageDataStore {
    
    
    // Var's
    var presenter: ChatMessagePresentationLogic?
    var worker = ChatMessageWorker()
  
    var chat: Chat?
    var lastId: Int?
    
    
    // Handler load
    func load(request: ChatMessage.Load.Request) {
        
        worker.load { loopTime in
            let response = ChatMessage.Load.Response(
                chat: self.chat,
                loopTime: loopTime
            )
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: ChatMessage.Fetch.Request) {
        
        worker.fetch(chat: self.chat, lastId: self.lastId) { messages, lastId, error in
            
            // Store in memory
            self.lastId = lastId
            
            let response = ChatMessage.Fetch.Response(messages: messages, error: error)
            self.presenter?.fetch(response: response)
        }
    }
    
    
    // Handler send
    func send(request: ChatMessage.Send.Request) {
        
        worker.send(chat: self.chat, text: request.text) { message, error in
            let response = ChatMessage.Send.Response(message: message, error: error)
            self.presenter?.send(response: response)
        }
        
    }
    
    
}
