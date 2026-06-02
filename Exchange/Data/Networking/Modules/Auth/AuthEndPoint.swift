import Foundation


enum AuthEndpoint {
    
    static func loginAnonymous() -> String { "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/auth/login/anonymous" }
    static func accessCode() -> String { "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/auth/access-code" }
    static func login() -> String { "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/auth/login" }
    
}
    
