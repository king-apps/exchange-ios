import UIKit


enum MatchFilter {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
    enum Fetch {
        struct Request {
           
        }
        struct Response {
            var localConfig: LocalConfig
            var remoteConfig: RemoteConfig
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            var radius: Float
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }
    
    
}
