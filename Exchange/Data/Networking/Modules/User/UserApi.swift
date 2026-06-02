import Foundation
import Alamofire


class UserApi {
    
    
    func localization(request: UserLocalizationRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.localization(request: request),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    
    func delete(completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.delete(),
            method: .delete,
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    
    func fcmToken(request: UserFcmTokenRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.fcmToken(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    
    func avatar(request: UserAvatarRequestDTO, completion: @escaping(_ user: User?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.upload(
            multipartFormData: { formData in
                formData.append(
                    request.data,
                    withName: "avatar",
                    fileName: "avatar",
                    mimeType: "image/png"
                )
            },
            to: UserEndpoint.avatar(),
            method: .post
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDTO.self) { response in
            if let dto = response.value {
                let user = User(dto: dto)
                completion(user, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    func update(request: UserUpdateRequestDTO, completion: @escaping(_ user: User?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.update(),
            method: .put,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDTO.self) { response in
            if let dto = response.value {
                let user = User(dto: dto)
                completion(user, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
    }
    
    
    func profile(completion: @escaping(_ user: User?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.profile(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDTO.self) { response in
            if let dto = response.value {
                let user = User(dto: dto)
                completion(user, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    func emailValidationSend(request: UserEmailValidationSendDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.emailValidationSend(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    func emailValidationValidate(request: UserEmailValidationValidateDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.emailValidationValidate(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
  
    
    func linkEmailSend(request: UserLinkEmailSendDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.linkEmailSend(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    func linkEmailValidate(request: UserLinkEmailValidateDTO, completion: @escaping(_ user: User?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            UserEndpoint.linkEmailValidate(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDTO.self) { response in
            if let dto = response.value {
                let user = User(dto: dto)
                completion(user, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
}
