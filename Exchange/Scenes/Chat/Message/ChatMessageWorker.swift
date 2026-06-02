//
//  ChatMessageWorker.swift
//  Exchange
//
//  Created by Douglas Cicarello on 15/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import KingOS


class ChatMessageWorker {
   
    
    // Handler load
    func load(completion: @escaping(_ loopTime: Int) -> ()) {
        let loopTime = RemoteConfig.shared.getChatLoopTime()
        completion(loopTime)
    }
    
    
    // Handler fetch
    func fetch(chat: Chat?, lastId: Int?, completion: @escaping(_ messages: [Message]?, _ lastId: Int?, _ error: String?) -> ()) {
        
        let api = MatchApi()
        let request = MatchChatMessagesRequestDTO(
            id: chat?.getId() ?? 0, messageLastId: lastId)
        api.chatMessages(request: request) { messages, error in
            
            var lastId = lastId
           
            if let messages = messages {
                if let message = messages.last(where: {$0.getType() != .me}) {
                    lastId = message.getId()
                }
            }
            
            completion(messages, lastId, error)
        }
    }
    
    
    // Handler send
    func send(chat: Chat?, text: String, completion: @escaping(_ message: Message?, _ error: String?) -> ()) {
        
        if let chat = chat {
            let request = MatchChatSendMessageRequestDTO(
                text: text
            )
            let api = MatchApi()
            api.chatSendMessage(id: chat.getId(), request: request) { message, error in
                completion(message, error)
            }
        } else {
            completion(nil, "Error.500".localized)
        }
    }
    
}
