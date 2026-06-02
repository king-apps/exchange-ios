import StoreKit
import UIKit


protocol SuperLikeBusinessLogic {
    func load(request: SuperLike.Load.Request)
    func fetch(request: SuperLike.Fetch.Request)
    func send(request: SuperLike.Send.Request)
}


protocol SuperLikeDataStore {
    var product: Product? { get set }
}


class SuperLikeInteractor: SuperLikeBusinessLogic, SuperLikeDataStore {
    
    
    // Var's
    var presenter: SuperLikePresentationLogic?
    var worker = SuperLikeWorker()
    
    var product: Product?
    private var storeProduct: SKProduct?
  
    
    // Handler load
    func load(request: SuperLike.Load.Request) {
        
        worker.load {
            let response = SuperLike.Load.Response(product: self.product)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: SuperLike.Fetch.Request) {
        worker.fetch { product, price in
            self.storeProduct = product
            let response = SuperLike.Fetch.Response(price: price)
            self.presenter?.fetch(response: response)
        }
    }
    
    
    // Handler send
    func send(request: SuperLike.Send.Request) {
        
        worker.save(
            product: self.product,
            storeProduct: self.storeProduct,
            message: request.message
        ) { error in
            let response = SuperLike.Send.Response(error: error)
            self.presenter?.send(response: response)
        }
        
    }
    
    
}
