import Foundation
import Alamofire


final class AuthInputEmailWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(name: String?, email: String, completion: @escaping(_ error: String?) -> ())  {
        
        let api = AuthApi()
        
        let request = AuthAccessCodeRequestDTO(name: name, email: email)
        api.accessCode(request: request) { error in
            completion(error)
        }
        
    }
    
    
}
