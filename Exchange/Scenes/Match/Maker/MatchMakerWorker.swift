import UIKit
import AppTrackingTransparency


class MatchMakerWorker {
   
    
    // Handler load
    func load(completion: @escaping(_ radius: Int, _ categories: [Int]) -> ()) {
        
        let radius = LocalConfig.shared.getRadius()
        let categories = LocalConfig.shared.getCategories()
        
        completion(radius, categories)
    }
    
    
    // Handler search
    func search(page: Int, completion: @escaping(_ list: [Product]?, _ error: String?) -> ()) {
        
        let api = MatchApi()
        let radius = LocalConfig.shared.getRadius()
        let categories = LocalConfig.shared.getCategories()
        
        let request: MatchSearchRequestDTO = .init(
            radius: radius,
            categories: categories,
            page: page
        )
        
        api.search(request: request) { products, error in
            completion(products, error)
        }
         
    }
    
    
    // Handler location
    func location(latitude: Double, longitude: Double, completion:@escaping(_ error: String?) -> ()) {
        
        let api = UserApi()
        let request: UserLocalizationRequestDTO = .init(
            latitude: latitude,
            longitude: longitude
        )
        api.localization(request: request) { error in
            completion(error)
        }
    }
    

    // Handler notification service
    func notification(completion: @escaping(_ granted: Bool) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (AppConfig.Animation.duration * 4), execute: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
                completion(granted)
            }
        })
        
    }
    
    
    // Handler tracking
    func tracking(completion: @escaping(_ authorized: Bool) -> ()) {
        
        var value = true
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + (AppConfig.Animation.duration * 4), execute: {
                ATTrackingManager.requestTrackingAuthorization { status in
                    value = status == .authorized
                    completion(value)
                }
            })
        }
        else {
            completion(value)
        }
        
    }

    
    // Handler intention
    func intention(productId: Int, option: MatchMakerOption, completion: @escaping(_ intention: ProductIntention?, _ error: String?) -> ()) {

        let api = MatchApi()
        let request: MatchProductIntentionRequestDTO = .init(
            productId: productId,
            intention: option.rawValue
        )
        api.intention(request: request) { intention, error in
            completion(intention, error)
        }
      
    }
    
    
    // Handler detail
    func detail(productId: Int, list:[Product], completion: @escaping(_ product: Product?) -> ()) {
        
        let product = list.filter({$0.getId() == productId}).first
        completion(product)
        
    }
    
    
    // Handler count my products
    func countMyProducts(completion: @escaping(_ myProducts: Int?, _ error: String?) -> ()) {
        
        let api = ProductApi()
        api.count { count, error in
            completion(count, error)
        }
        
    }
    
    
    // Handler ad
    func ad() -> String? {
        nil
    }
   
    
    // Handler super like
    func superLike(productId: Int, products: [Product], completion: @escaping(_ product: Product?) -> ()) {
        
        let product = products.filter({$0.getId() == productId}).first
        completion(product)
        
    }
    
    
    // Handler boost profile
    func boostProfile(completion: @escaping(_ error: String?) -> ()) {
     
        let api = ProductApi()
        api.boost { remainingMinutes, error in
            if let error {
                completion(error)
                return
            }
            else {
                User.shared.setBoostRemainingMinutes(remainingMinutes)
                completion(nil)
            }
        }
    
    }
    func boostProfileStatus(completion: @escaping(_ isActive: Bool) -> ()) {
        
        
        if User.shared.getBoostProfileIsActive() {
            let api = ProductApi()
            api.boostStatus { remainingMinutes, error in
                User.shared.setBoostRemainingMinutes(remainingMinutes)
                let isActive = User.shared.getBoostProfileIsActive()
                completion(isActive)
            }
            
        }
        else {
            completion(false)
        }
        
    }
    
    
}
