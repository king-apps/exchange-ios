import Foundation
import Alamofire


class ProductApi {
    
    
    func denunciate(request: ProductDenunciateRequestDTO, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.denunciate(),
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    
    func categories(completion: @escaping(_ categories: [ProductCategory]?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.categories(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductCategoriesResponseDTO.self) { response in
            switch response.result {
            case .success(let dto):
                let categories = dto.map { ProductCategory(dto: $0) }
                completion(categories, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    
    func save(request: ProductSaveRequestDTO, completion: @escaping(_ product: Product?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.upload(
            multipartFormData: { formData in
                formData.append(
                    Data(request.title.utf8),
                    withName: "title"
                )
                formData.append(
                    Data(String(request.categoryId).utf8),
                    withName: "categoryId"
                )
                
                for (index, image) in request.images.enumerated() {
                    formData.append(
                        image,
                        withName: "images",
                        fileName: "\(Date().timeIntervalSince1970)-\(index).png",
                        mimeType: "image/png"
                    )
                }
            },
            to: ProductEndpoint.save(),
            method: .post
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductDTO.self) { response in
            if let dto = response.value {
                let product = Product(dto: dto)
                completion(product, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    func list(completion: @escaping(_ products: [Product]?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.list(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [ProductDTO].self) { response in
            switch response.result {
            case .success(let dto):
                let products = dto.map { Product(dto: $0) }
                completion(products, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    
    func delete(id: Int, completion: @escaping(_ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.delete(id: id),
            method: .delete,
        )
        .validate(statusCode: 200..<300)
        .response(completionHandler: { response in
            completion(response.error?.localizedDescription)
        })
        
    }
    
    
    func count(completion: @escaping(_ count: Int?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.countMyProducts(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductCountResponseDTO.self) { response in
            if let dto = response.value {
                completion(dto.myProducts, nil)
            }
            else {
                completion(nil, response.error?.localizedDescription)
            }
        }
        
    }
    
    
    func boost(completion: @escaping(_ remainingMinutes: Int?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.boost(),
            method: .post
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductBoostResponseDTO.self) { response in
            switch response.result {
            case .success(let dto):
                completion(dto.remainingMinutes, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    func boostStatus(completion: @escaping(_ remainingMinutes: Int?, _ error: String?) -> ()) {
        
        ApiClient.shared.session.request(
            ProductEndpoint.boostStatus(),
            method: .get
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ProductBoostResponseDTO.self) { response in
            switch response.result {
            case .success(let dto):
                completion(dto.remainingMinutes, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
}
