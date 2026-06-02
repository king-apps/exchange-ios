import UIKit


protocol MyProductListBusinessLogic {
    func load(request: MyProductList.Load.Request)
    func fetch(request: MyProductList.Fetch.Request)
    func detail(request: MyProductList.Detail.Request)
    func delete(request: MyProductList.Delete.Request)
}


protocol MyProductListDataStore {
    var product: Product? { get }
}


class MyProductListInteractor: MyProductListBusinessLogic, MyProductListDataStore {
    
    
    // Var's
    var presenter: MyProductListPresentationLogic?
    var worker = MyProductListWorker()
    
    var product: Product?
    var products: [Product]?
  
    
    // Handler load
    func load(request: MyProductList.Load.Request) {
        
        worker.load {
            let response = MyProductList.Load.Response()
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler fetch
    func fetch(request: MyProductList.Fetch.Request) {
        
        worker.fetch { products, error in
            let response = MyProductList.Fetch.Response(products: products, error: error)
            self.presenter?.fetch(response: response)
        }
        
    }
    
    
    // Handler detail
    func detail(request: MyProductList.Detail.Request) {
        
        let product = worker.detail(id: request.id, list: self.products)
        
        // Store in memory
        self.product = product
        
        let response = MyProductList.Detail.Response(product: product)
        presenter?.detail(response: response)
        
    }
    
    
    // Handler delete
    func delete(request: MyProductList.Delete.Request) {
        
        if let product = self.products?.filter({$0.getId() == request.id}).first {
            worker.delete(id: product.getId()) { error in
                let response = MyProductList.Delete.Response(error: error)
                self.presenter?.delete(response: response)
            }
        }
        
    }
    
    
}
