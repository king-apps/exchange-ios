import UIKit


protocol ChatListPresentationLogic {
    func load(response: ChatList.Load.Response)
    func fetch(response: ChatList.Fetch.Response)
    func save(response: ChatList.Save.Response)
    func delete(response: ChatList.Delete.Response)
}


class ChatListPresenter: ChatListPresentationLogic {
  
    
    // Var's
    weak var viewController: ChatListDisplayLogic?
  
    
    // Handler load
    func load(response: ChatList.Load.Response) {
        
        let rows: [MainTableRow] = [
            .loading(.init(height: response.height))
        ]
        
        let viewModel = ChatList.Load.ViewModel(rows: rows)
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: ChatList.Fetch.Response) {
        
        if let error = response.error {
            viewController?.onFetch(error: error)
        }
        else {
            var rows: [MainTableRow] = []
            var unreadCount: Int = 0
            
            if let chats = response.chats, chats.count > 0 {
                
                // SUPER LIKE
                let chatsSuperLike = chats.filter({$0.getType() == .superlike})
                if chatsSuperLike.count > 0 {
                    rows.append(
                        .textCaptionSemibold(
                            .init(
                                color: .brandPrimary500,
                                icon: .starFill,
                                title: "App.SuperLike".localized.uppercased()
                            )
                        )
                    )
                    for chat in chatsSuperLike {
                        rows.append(
                            .chatList(
                                .init(
                                    id: chat.getId(),
                                    avatarUrl: chat.getAvatarUrl(),
                                    name: chat.getName(),
                                    message: chat.getLastMessage(),
                                    notViewed: chat.getNotViewed()
                                )
                            )
                        )
                        unreadCount += chat.getNotViewed()
                    }
                    rows.append(.spacing(.init(size: .xxl)))
                }
                
                
                // MATCHS
                let chatsMatch = chats.filter({$0.getType() == .match})
                if chatsMatch.count > 0 {
                    rows.append(
                        .textCaptionSemibold(
                            .init(
                                color: .brandPrimary500,
                                icon: .likeFill,
                                title: "App.Matchs".localized.uppercased()
                            )
                        )
                    )
                    for chat in chatsMatch {
                        rows.append(
                            .chatList(
                                .init(
                                    id: chat.getId(),
                                    avatarUrl: chat.getAvatarUrl(),
                                    name: chat.getName(),
                                    message: chat.getLastMessage(),
                                    notViewed: chat.getNotViewed()
                                )
                            )
                        )
                        
                        unreadCount += chat.getNotViewed()
                    }
                    rows.append(.spacing(.init(size: .xxl)))
                }
                
                
            }
            else {
                rows.append(
                    .empty(
                        .init(
                            icon: .messageCircle,
                            text: "Chat.List.Empty".localized
                        )
                    )
                )
            }
            
            let viewModel = ChatList.Fetch.ViewModel(
                rows: rows,
                unreadCount: unreadCount
            )
            viewController?.onFetch(viewModel: viewModel)
        }
    }
    
    
    // Handler save
    func save(response: ChatList.Save.Response) {
        
        let viewModel = ChatList.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }
    
    
    // Handler delete
    func delete(response: ChatList.Delete.Response) {
        
        if let error = response.error {
            viewController?.onDelete(error: error)
        }
        else {
            let viewModel = ChatList.Delete.ViewModel()
            viewController?.onDelete(viewModel: viewModel)
        }
        
    }
    
    
}
