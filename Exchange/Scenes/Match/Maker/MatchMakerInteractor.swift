import UIKit


protocol MatchMakerBusinessLogic {
    func load(request: MatchMaker.Load.Request)
    func location(request: MatchMaker.Location.Request)
    func notification(request: MatchMaker.Notification.Request)
    func tracking(request: MatchMaker.Tracking.Request)
    func search(request: MatchMaker.Search.Request)
    func intention(request: MatchMaker.Intention.Request)
    func detail(request: MatchMaker.Detail.Request)
    func countMyProducts(request: MatchMaker.CountMyProducts.Request)
    func ad(request: MatchMaker.Ad.Request)
    func superLike(request: MatchMaker.SuperLike.Request)
    func boostProfile(request: MatchMaker.BoostProfile.Request)
    func boostProfileStatus(request: MatchMaker.BoostProfileStatus.Request)
}


protocol MatchMakerDataStore {
    var product: Product? { get }
    var productIntention: ProductIntention? { get }
}


class MatchMakerInteractor: MatchMakerBusinessLogic, MatchMakerDataStore {
    
    
    // Var's
    var presenter: MatchMakerPresentationLogic?
    var worker = MatchMakerWorker()
    var product: Product?
    var list = [Product]()
    var productIntention: ProductIntention?
  
    
    // Handler load
    func load(request: MatchMaker.Load.Request) {
        
        worker.load { (radius, categories) in
            let response = MatchMaker.Load.Response(
                radius: radius,
                categories: categories
            )
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler location
    func location(request: MatchMaker.Location.Request) {
        
        worker.location(latitude: request.latitude, longitude: request.longitude) { (error) in
            let response = MatchMaker.Location.Response(error: error)
            self.presenter?.location(response: response)
        }
        
    }
    
    
    // Handler notification
    func notification(request: MatchMaker.Notification.Request) {
        
        worker.notification { (granted) in
            let response = MatchMaker.Notification.Response(granted: granted)
            self.presenter?.notification(response: response)
        }
        
    }
    
    
    // Handler tracking
    func tracking(request: MatchMaker.Tracking.Request) {
        
        worker.tracking { authorized in
            let response = MatchMaker.Tracking.Response(authorized: authorized)
            self.presenter?.tracking(response: response)
        }
        
    }
    
    
    // Handler search
    func search(request: MatchMaker.Search.Request) {
        
        worker.search(page: request.page) { (list, error) in
            
            // Store in memory
            if let products = list {
                //self.list += products
                self.list = products
            }
            
            let response = MatchMaker.Search.Response(list: list, error: error)
            self.presenter?.search(response: response)
        }
    }
    
    
    // Handler intention
    func intention(request: MatchMaker.Intention.Request) {
        
        worker.intention(productId: request.productId, option: request.option) { (intention, error) in
            
            // Store in memory
            self.productIntention = intention
            
            let response = MatchMaker.Intention.Response(intention: intention, error: error)
            self.presenter?.intention(response: response)
        }
    }
    
    
    // Handler detail
    func detail(request: MatchMaker.Detail.Request) {
        
        worker.detail(productId: request.productId, list: self.list) { (product) in
            self.product = product
            
            let response = MatchMaker.Detail.Response(product: product)
            self.presenter?.detail(response: response)
        }
        
    }
    
    
    // Handler count my products
    func countMyProducts(request: MatchMaker.CountMyProducts.Request) {
        
        worker.countMyProducts { myProducts, error in
            let response = MatchMaker.CountMyProducts.Response(myProducts: myProducts, error: error)
            self.presenter?.countMyProducts(response: response)
        }
        
    }
    
    
    // Handler ad
    func ad(request: MatchMaker.Ad.Request) {
        
        let adUnitId = worker.ad()
        let response = MatchMaker.Ad.Response(adUnitId: adUnitId)
        presenter?.ad(response: response)
        
    }
    
    
    // Handler super like
    func superLike(request: MatchMaker.SuperLike.Request) {
        
        worker.superLike(productId: request.productId, products: self.list) { product in
            
            // Store in memory
            self.product = product
            
            let response = MatchMaker.SuperLike.Response(product: product)
            self.presenter?.superLike(response: response)
        }
        
    }
    
    
    // Handler boost profile
    func boostProfile(request: MatchMaker.BoostProfile.Request) {
        
        worker.boostProfile { error in
            let response = MatchMaker.BoostProfile.Response(error: error)
            self.presenter?.boostProfile(response: response)
        }
        
    }
    func boostProfileStatus(request: MatchMaker.BoostProfileStatus.Request) {
        
        worker.boostProfileStatus { isActive in
            let response = MatchMaker.BoostProfileStatus.Response(isActive: isActive)
            self.presenter?.boostProfileStatus(response: response)
        }
        
    }
    
    
}
