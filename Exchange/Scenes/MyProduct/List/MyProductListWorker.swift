import UIKit


class MyProductListWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler search
    func fetch(completion: @escaping(_ products: [Product]?, _ error: String?) -> ()) {
        /*
        let api = ProductApi()
        api.list { (list, error) in
            completion(list, error)
        }
        */
    }
    
    
    // Handler detail
    func detail(id: Int, list: [Product]?) -> Product? {
        
        if let list = list {
            if let product = list.filter({$0.getId() == id}).first {
                return product
            }
        }
        
        return nil
    }
    
    
    // Handler delete
    func delete(id: Int, completion: @escaping(_ error: String?) -> ()) {
        /*
        let api = ProductApi()
        api.delete(productId: id) { error in
            completion(error)
        }
        */
    }
    
    
}
