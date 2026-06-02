import UIKit


protocol MyProductInputImagePresentationLogic {
    func load(response: MyProductInputImage.Load.Response)
    func save(response: MyProductInputImage.Save.Response)
}


class MyProductInputImagePresenter: MyProductInputImagePresentationLogic {
  
    
    // Var's
    weak var viewController: MyProductInputImageDisplayLogic?
  
    
    // Handler load
    func load(response: MyProductInputImage.Load.Response) {
        
        if let product = response.product {
            let viewModel = MyProductInputImage.Load.ViewModel(
                name: "\(product.category.getCode()) \(product.getTitle())",
                category: product.category.getName(),
                categoryUrl: product.category.getLogo().isEmpty ? nil : product.category.getLogo(),
                conservation: "",
                description: "",
                color: product.category.getPrimaryColor()
            )
            viewController?.onLoad(viewModel: viewModel)
        }
    
    }
    
    
    // Handler save
    func save(response: MyProductInputImage.Save.Response) {
        
        if let error = response.error {
            viewController?.onSaveError(error: error)
        }
        else {
            let viewModel = MyProductInputImage.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
        }
        
    }
    
    
}
