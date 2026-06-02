nonisolated
struct ProductDTO: Decodable {
    let id: Int
    let distance: Int
    let title: String
    let conservationStatus: String?
    let description: String?
    let status: String
    let category: ProductCategoryDTO
    let images: [ProductImageDTO]
}






