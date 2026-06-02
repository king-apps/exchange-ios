import Foundation
import StoreKit


extension InAppPurchase: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            switch transaction.transactionState {
            case .purchased, .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                handlePurchaseFinished(success: true)
                
            case .failed:
                let nsError = transaction.error as NSError?
                if nsError?.code == SKError.paymentCancelled.rawValue {
                    handlePurchaseFinished(success: false, error: InAppPurchaseError.purchaseCancelled)
                }
                else {
                    handlePurchaseFinished(success: false, error: transaction.error)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case .deferred, .purchasing:
                break
                
            @unknown default:
                break
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        let identifiers = queue.transactions.map { $0.payment.productIdentifier }
        handleRestoreFinished(with: identifiers)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        handleRestoreFailure(error)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
}
