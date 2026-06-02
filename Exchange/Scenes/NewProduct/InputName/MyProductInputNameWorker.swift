import UIKit


class MyProductInputNameWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(name: String, completion: @escaping(_ error: String?) -> ()) {
    
        var error: String?
        if name.count < 1 {
            error = "MyProduct.InputName.Error.Length".localized
        }
        
        completion(error)
        
    }
    
    
}
