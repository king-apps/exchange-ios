import UIKit


protocol ItsAMatchBusinessLogic {
    func load(request: ItsAMatch.Load.Request)
}


protocol ItsAMatchDataStore {
    var productIntention: ProductIntention? { get set }
}


class ItsAMatchInteractor: ItsAMatchBusinessLogic, ItsAMatchDataStore {
    
    
    // Var's
    var presenter: ItsAMatchPresentationLogic?
    var worker = ItsAMatchWorker()
    
    var productIntention: ProductIntention?
  
    
    // Handler load
    func load(request: ItsAMatch.Load.Request) {
        
        worker.load {
            let response = ItsAMatch.Load.Response(productIntention: self.productIntention)
            self.presenter?.load(response: response)
        }
        
    }
    
    
}
