import UIKit


enum MatchMaker {
  
    
    enum Load {
        struct Request {
        }
        struct Response {
            var radius: Int
            var categories: [Int]
        }
        struct ViewModel {
            var radius: Int
            var categories: [Int]
        }
    }
    
    
    enum Search {
        struct Request {
            var page: Int
        }
        struct Response {
            var list: [Product]?
            var error: String?
        }
        struct ViewModel {
            var cards: [CardModel]
        }
    }

    
    enum Location {
        struct Request {
            var latitude: Double
            var longitude: Double
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
            
        }
    }
    
    
    enum Notification {
        struct Request {
            
        }
        struct Response {
            var granted: Bool
        }
        struct ViewModel {
            var granted: Bool
        }
    }
    
    
    enum Tracking {
        struct Request {
            
        }
        struct Response {
            var authorized: Bool
        }
        struct ViewModel {
            var authorized: Bool
        }
    }
    
    
    enum Intention {
        struct Request {
            var productId: Int
            var option: MatchMakerOption
        }
        struct Response {
            var intention: ProductIntention?
            var error: String?
        }
        struct ViewModel {
            var match: Bool
        }
    }
    
    
    enum Detail {
        struct Request {
            var productId: Int
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
    
        }
    }
    
    
    enum CountMyProducts {
        struct Request {
            
        }
        struct Response {
            var myProducts: Int?
            var error: String?
        }
        struct ViewModel {
            var myProducts: Int
        }
    }
    
    
    enum Ad {
        struct Request {
            
        }
        struct Response {
            var adUnitId: String?
        }
        struct ViewModel {
            var adUnitId: String
        }
    }
    
    
    enum SuperLike {
        struct Request {
            var productId: Int
        }
        struct Response {
            var product: Product?
        }
        struct ViewModel {
            
        }
    }
    
    
    enum BoostProfile {
        struct Request {
            
        }
        struct Response {
            var error: String?
        }
        struct ViewModel {
        
        }
    }
    
    
    enum BoostProfileStatus {
        struct Request {
            
        }
        struct Response {
            var isActive: Bool
        }
        struct ViewModel {
            var isActive: Bool
        }
    }
    
}
