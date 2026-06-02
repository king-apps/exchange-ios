import Foundation
import Alamofire


class AuthApi {
    
    
    
    func loginAnonymous(completion: @escaping(_ auth: Auth?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            AuthEndpoint.loginAnonymous(),
            method: .post,
            encoding: JSONEncoding.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: AuthLoginResponseDTO.self) { response in
            if let dto = response.value {
                let auth = Auth(dto: dto)
                completion(auth, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    // Access code
    func accessCode(request: AuthAccessCodeRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            AuthEndpoint.accessCode(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
        
    }
    
    
    // Login
    func login(request: AuthLoginRequestDTO, completion: @escaping(_ auth: Auth?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            AuthEndpoint.login(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: AuthLoginResponseDTO.self) { response in
            if let dto = response.value {
                let auth = Auth(dto: dto)
                completion(auth, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    
}

