import UIKit


protocol MyProductDetailBusinessLogic {
    func load(request: MyProductDetail.Load.Request)
    func save(request: MyProductDetail.Save.Request)
    func remove(request: MyProductDetail.Remove.Request)
}


protocol MyProductDetailDataStore {
    var product: Product? { get set }
}


class MyProductDetailInteractor: MyProductDetailBusinessLogic, MyProductDetailDataStore {
    
    
    // Var's
    var presenter: MyProductDetailPresentationLogic?
    var worker = MyProductDetailWorker()
  
    var product: Product?
    
    
    // Handler load
    func load(request: MyProductDetail.Load.Request) {
        
        worker.load {
            let response = MyProductDetail.Load.Response(product: self.product)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: MyProductDetail.Save.Request) {
        
        worker.save(product: self.product, images: request.images) { (error) in
            let response = MyProductDetail.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
    }
    
    
    // Handler remove
    func remove(request: MyProductDetail.Remove.Request) {
        
        worker.remove(productId: product?.getId()) { (error) in
            let response = MyProductDetail.Remove.Response(error: error)
            self.presenter?.remove(response: response)
        }
        
    }
    
    
}
