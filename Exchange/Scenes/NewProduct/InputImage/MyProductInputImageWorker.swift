import UIKit


class MyProductInputImageWorker {
   
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler save
    func save(product: Product?, images: [UIImage?], completion: @escaping(_ error: String?) -> () ) {
        
        if let product = product {
            /*
            let api = ProductApi()
            var datas = [Data]()
            
            for image in images {
                if let i = image, let resize = i.resize(to: kProductInputImageMaxSendSize), let data = resize.pngData() {
                    datas.append(data)
                }
            }
            
            api.save(
                title: "\(product.category.getCode()) \(product.getTitle())",
                categoryId: product.category.getId(),
                images: datas
            ) { product, error in
                completion(error)
            }
            */
        }
        else {
            completion("Verifique todos os campos e tente novamente")
        }
    }
 
    
}
