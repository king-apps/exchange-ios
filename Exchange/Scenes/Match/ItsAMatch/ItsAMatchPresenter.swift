import UIKit


protocol ItsAMatchPresentationLogic {
    func load(response: ItsAMatch.Load.Response)
}


class ItsAMatchPresenter: ItsAMatchPresentationLogic {
  
    
    // Var's
    weak var viewController: ItsAMatchDisplayLogic?
  
    
    // Handler load
    func load(response: ItsAMatch.Load.Response) {
        
        if let productIntention = response.productIntention {
            
            if let hisProduct = response.productIntention?.hisLikedProducts.first, let image = hisProduct.images.first {
                
                let description = "ItsAMatch.Description".localized.replacingOccurrences(of: "{$0}", with: productIntention.productOwner.getName())
                
                let viewModel = ItsAMatch.Load.ViewModel(
                    image: image.getUrl(),
                    categoryUrl: hisProduct.category.getLogo(),
                    name: hisProduct.getTitle(),
                    description: description
                )
                viewController?.onLoad(viewModel: viewModel)
            }
        }
        
        
        
    }
    
    
}
