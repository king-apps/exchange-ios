import UIKit


protocol MyProductInputNamePresentationLogic {
    func load(response: MyProductInputName.Load.Response)
    func save(response: MyProductInputName.Save.Response)
}


class MyProductInputNamePresenter: MyProductInputNamePresentationLogic {
  
    
    // Var's
    weak var viewController: MyProductInputNameDisplayLogic?
  
    
    // Handler load
    func load(response: MyProductInputName.Load.Response) {
        
        let product = response.product
        let code = product?.category.getCode() ?? ""
        let color = product?.category.getPrimaryColor()
        
        let viewModel = MyProductInputName.Load.ViewModel(
            code: code,
            color: color
        )
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: MyProductInputName.Save.Response) {
        
        if let error = response.error {
            viewController?.onSaveError(error: error)
        }
        else {
            let viewModel = MyProductInputName.Save.ViewModel()
            viewController?.onSave(viewModel: viewModel)
            
        }
    }
    
    
}
