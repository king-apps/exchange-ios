import UIKit


protocol MyProductInputNameBusinessLogic {
    func load(request: MyProductInputName.Load.Request)
    func save(request: MyProductInputName.Save.Request)
}


protocol MyProductInputNameDataStore {
    var product: Product? { get set }
}


class MyProductInputNameInteractor: MyProductInputNameBusinessLogic, MyProductInputNameDataStore {
    
    
    // Var's
    var presenter: MyProductInputNamePresentationLogic?
    var worker = MyProductInputNameWorker()
  
    var product: Product?
    
    
    // Handler load
    func load(request: MyProductInputName.Load.Request) {
        
        worker.load {
            let response = MyProductInputName.Load.Response(product: self.product)
            self.presenter?.load(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: MyProductInputName.Save.Request) {
        
        worker.save(name: request.name) { (error) in
        
            // Save in memory
            self.product?.setTitle(request.name)
            
            let response = MyProductInputName.Save.Response(error: error)
            self.presenter?.save(response: response)
        }
    }
    
    
}
