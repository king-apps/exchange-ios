import UIKit


class MyProductDetailWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(product: Product?, images: [UIImage?], completion: @escaping(_ error: String?) -> ()) {
        
        if let product = product {
            /*
            let api = ProductApi()
            var datas = [Data]()
            
            for image in images {
                if let i = image, let resize = i.resize(to:  kProductInputImageMaxSendSize), let data = resize.pngData() {
                    datas.append(data)
                }
            }
            
            api.update(
                id: product.getId(),
                title: product.getTitle(),
                categoryId: product.category.getId(),
                images: datas) { product, error in
                    completion(error)
                }
             */

        }
        
        
    }
    
    
    // Handler remove
    func remove(productId: Int?, completion: @escaping(_ error: String?) -> ()) {
        /*
        if let productId = productId {
            let api = ProductApi()
            api.delete(productId: productId) { (error) in
                completion(error)
            }
        }
        */
    }
    
    
}
