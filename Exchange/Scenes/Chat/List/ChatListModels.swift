//
//  ChatListModels.swift
//  Exchange
//
//  Created by Douglas Cicarello on 04/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


enum ChatList {
  
    
    enum Load {
        struct Request {
            var height: CGFloat
        }
        struct Response {
            var height: CGFloat
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Fetch {
        struct Request {
            
        }
        struct Response {
            var chats: [Chat]?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
            var unreadCount: Int
        }
    }
    
    
    enum Save {
        struct Request {
            var chatId: Int
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Delete {
        struct Request {
            var chatId: Int
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
}
