import UIKit


enum MyProductList {
  
    
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
            var products: [Product]?
            var error: String?
        }
        struct ViewModel {
            var rows: [MainTableRow]
        }
    }
    

    
    enum Detail {
        struct Request {
            var id: Int
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            
        }
    }
    
    enum Delete {
        struct Request {
            var id: Int
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
}
