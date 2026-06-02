import Foundation


enum ProductEndpoint {
    
    static func denunciate() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/denunciate"
    }
    static func categories() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/categories"
    }
    static func save() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product"
    }
    static func list() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product"
    }
    static func delete(id: Int) -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/\(id)"
    }
    static func countMyProducts() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/count-my-products"
    }
    static func boost() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/boost"
    }
    static func boostStatus() -> String {
        "\(ApiEnvironment.baseUrl)/\(ApiEnvironment.appId)/product/boost/status"
    }
    
}
