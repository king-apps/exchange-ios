import Foundation
import Alamofire


class MatchApi {
    

    func search(request: MatchSearchRequestDTO, completion: @escaping(_ products: [Product]?, _ error: String?) -> ()) {
        var parameters = [
            "radius": "\(request.radius)",
            "page": "\(request.page)"
        ]
        
        if !request.categories.isEmpty {
            parameters["categories"] = request.categories.map { String($0) }.joined(separator: ",")
        }
        
        ApiClient.shared.session.request(
            MatchEndpoint.search(request: request),
            method: .get,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MatchSearchResponseDTO.self) { response in
            switch response.result {
            case .success(let list):
                let products = list.map { Product(dto: $0) }
                completion(products, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    
    func intention(request: MatchProductIntentionRequestDTO, completion: @escaping(_ intention: ProductIntention? , _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.intention(request: request),
            method: .post,
            parameters: request,
            encoder: URLEncodedFormParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductIntentionDTO.self) { response in
            if let dto = response.value {
                let intention = ProductIntention(dto: dto)
                completion(intention, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    func chat(completion: @escaping(_ chats: [Chat]?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chat(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MatchChatResponseDTO.self) { response in
            if let dto = response.value {
                let chats = dto.map { Chat(dto: $0) }
                completion(chats, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    func chatDelete(request: MatchChatDeleteRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chatDelete(request: request),
            method: .delete,
        )
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    func chatDenunciate(request: MatchChatDenunciateRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chatDenunciate(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    func chatMessages(request: MatchChatMessagesRequestDTO, completion: @escaping(_ messages: [Message]?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chatMessages(request: request),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MatchChatMessagesResponseDTO.self) { response in
            switch response.result {
            case .success(let dto):
                let messages = dto.map { Message(dto: $0) }
                completion(messages, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    func chatSendMessage(id: Int, request: MatchChatSendMessageRequestDTO, completion: @escaping(_ message: Message?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chatSendMessage(id: id),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MatchChatMessagesResponseDTO.self) { response in
            
            // Create local message
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let message = Message(json: [
                "id": 0,
                "text": request.text,
                "creationDate": formatter.string(from: Date()),
                "type": "\(MessageType.me.rawValue)"
            ])
            completion(message, nil)
            
        }
        
    }
    func chatProducts(id: Int, completion: @escaping(_ chatProducts: [ChatProduct]?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.chatProducts(id: id),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MatchChatProductsResponseDTO.self) { response in
            switch response.result {
            case .success(let dto):
                let chatProducts = dto.map { ChatProduct(dto: $0) }
                completion(chatProducts, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    
    func productSuperLike(request: MatchProductSuperLikeRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            MatchEndpoint.productSuperLike(id: request.id),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
}
