import UIKit


enum MatchFilterTagList {
  
    
    enum Load {
        struct Request {
            
        }
        struct Response {
            var categories: [ProductCategory]?
            var selectedProductCategories: [Int]
            var error: String?
        }
        struct ViewModel {
            var list: [MainTableRow]
        }
    }


    enum Select {
        struct Request {
            var index: Int
        }
        struct Response {
            var categories: [ProductCategory]
            var selectedProductCategories: [Int]
        }
        struct ViewModel {
            var list: [MainTableRow]
        }
    }
    
    
    enum Save {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
            
        }
    }

    
}
