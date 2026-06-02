//
//  ChatMessageModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 15/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ChatMessage {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var chat: Chat?
            var loopTime: Int
        }
        struct ViewModel {
            var name: String
            var avatarUrl: String
            var distante: String
            var chatId: Int
            var loopTime: Int
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var messages: [Message]?
            var lastId: Int?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Send {
        struct Request {
            var text: String
        }
        struct Response {
            var message: Message?
            var error: String?
        }
        struct ViewModel {
            var row: MainTableRow
        }
    }

    
}
