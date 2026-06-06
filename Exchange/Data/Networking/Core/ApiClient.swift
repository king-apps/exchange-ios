import UIKit
import Alamofire


class ApiClient {
    
    
    // Var's
    public static let shared = ApiClient()
    let session: Session
    
    
    // Construct
    private init() {
    
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let interceptor = ApiRequestInterceptor()
        #if DEBUG
        let eventMonitors: [EventMonitor] = [ApiLogger()]
        #else
        let eventMonitors: [EventMonitor] = []
        #endif
    
        session = Session(
            configuration: configuration,
            interceptor: interceptor,
            eventMonitors: eventMonitors
        )
        
    }
    
    
}
