//
//  ChatMessagePresenter.swift
//  Exchange
//
//  Created by Douglas Cicarello on 15/05/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


protocol ChatMessagePresentationLogic {
    func load(response: ChatMessage.Load.Response)
    func fetch(response: ChatMessage.Fetch.Response)
    func send(response: ChatMessage.Send.Response)
}


class ChatMessagePresenter: ChatMessagePresentationLogic {
  
    
    // Var's
    weak var viewController: ChatMessageDisplayLogic?
  
    
    // Handler load
    func load(response: ChatMessage.Load.Response) {
        
        if let chat = response.chat {
            
            var distance = "\(chat.getDistance())" + "App.Radius.Code".localized
            if chat.getDistance() <= 0 {
                distance = "App.Distance.Unavailable".localized
            }
            
            let viewModel = ChatMessage.Load.ViewModel(
                name: chat.getName(),
                avatarUrl: chat.getAvatarUrl(),
                distante: distance,
                chatId: chat.getId(),
                loopTime: response.loopTime
            )
            
            viewController?.onLoad(viewModel: viewModel)
        }
    
    }
    
    
    // Handler fetch
    func fetch(response: ChatMessage.Fetch.Response) {
        
        if let messages = response.messages {
            
            var rows: [MainTableRow] = []
            
            for message in messages {
                
                // App
                if message.getType() == .app {
                    rows.append(
                        .chatMessageApp(
                            .init(
                                text: message.getText()
                            )
                        )
                    )
                }
                
                // Me
                if message.getType() == .me {
                    rows.append(
                        .chatMessageMe(
                            .init(
                                text: message.getText(),
                                date: message.getCreationDateForHuman()
                            )
                        )
                    )
                }
                
                // He
                if message.getType() == .he {
                    rows.append(
                        .chatMessageHe(
                            .init(
                                text: message.getText(),
                                date: message.getCreationDateForHuman()
                            )
                        )
                    )
                }
                
            }
            
            let viewModel = ChatMessage.Fetch.ViewModel(rows: rows)
            viewController?.onFetch(viewModel: viewModel)
        }
        
    }
    
    
    // Handler send
    func send(response: ChatMessage.Send.Response) {
        
        if let message = response.message {
            let row: MainTableRow = .chatMessageMe(
                .init(
                    text: message.getText(),
                    date: message.getCreationDateForHuman()
                )
            )
            let viewModel = ChatMessage.Send.ViewModel(row: row)
            viewController?.onSend(viewModel: viewModel)
        }
        else {
            if let _ = response.error {
                
            }
            else {
                
            }
        }
    }
    
}
