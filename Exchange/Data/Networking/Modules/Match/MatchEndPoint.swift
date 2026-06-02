import Foundation


enum MatchEndpoint {
    
    static func search(request: MatchSearchRequestDTO) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/products"
    }
    static func intention(request: MatchProductIntentionRequestDTO) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/product/\(request.productId)/\(request.intention)"
    }
    static func chat() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat"
    }
    static func chatDelete(request: MatchChatDeleteRequestDTO) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/\(request.id)"
    }
    static func chatDenunciate() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/denunciate"
    }
    static func chatMessages(request: MatchChatMessagesRequestDTO) -> String {
        if let chatMessageLastId = request.messageLastId {
            return "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/\(request.id)/messages?lastId=\(chatMessageLastId)"
        } else {
            return "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/\(request.id)/messages"
        }
    }
    static func chatSendMessage(id: Int) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/\(id)/send"
    }
    static func chatProducts(id: Int) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/chat/\(id)/products"
    }
    static func productSuperLike(id: Int) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/match-maker/product/\(id)/superlike"
    }
}
