import UIKit


enum MyProductInputImage {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            var name: String
            var category: String
            var categoryUrl: String?
            var conservation: String
            var description: String
            var color: UIColor?
        }
    }
    
    
    enum Save {
        struct Request {
            var images: [UIImage?]
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }

    
}
