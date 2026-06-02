import Alamofire
import Foundation
 

final class ApiRequestInterceptor: RequestInterceptor {

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Swift.Result<URLRequest, any Error>) -> Void
    ) {
        var request = urlRequest
        
        for header in ApiEnvironment.defaultHeaders {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if Auth.shared.isAuth() {
            let token = Auth.shared.getToken()
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        completion(.success(request))
    }
    
}
