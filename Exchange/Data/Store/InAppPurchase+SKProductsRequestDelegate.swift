import Foundation
import StoreKit


extension InAppPurchase: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        handleProductsResponse(response, for: request)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        handleProductsRequestFailure(for: request)
    }
    
    func requestDidFinish(_ request: SKRequest) {
        // no-op
    }
    
}
