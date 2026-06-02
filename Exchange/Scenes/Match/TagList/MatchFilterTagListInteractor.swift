import UIKit


protocol MatchFilterTagListBusinessLogic {
    func load(request: MatchFilterTagList.Load.Request)
    func select(request: MatchFilterTagList.Select.Request)
    func save(request: MatchFilterTagList.Save.Request)
}


protocol MatchFilterTagListDataStore {
    
}


class MatchFilterTagListInteractor: MatchFilterTagListBusinessLogic, MatchFilterTagListDataStore {
    
    
    // Var's
    var presenter: MatchFilterTagListPresentationLogic?
    var worker = MatchFilterTagListWorker()
    
    private var productCategories = [ProductCategory]()
    private var selectedProductCategories = [Int]()
  
    
    // Handler load
    func load(request: MatchFilterTagList.Load.Request) {
        
        worker.load { list, error in
            
            // Store in memory
            self.productCategories = list ?? []
            self.selectedProductCategories = self.worker.getSettingsProductCategories()
            
            let response = MatchFilterTagList.Load.Response(
                categories: list,
                selectedProductCategories: self.selectedProductCategories,
                error: error
            )
            
            self.presenter?.load(response: response)
        }
        
    }


    // Handler select
    func select(request: MatchFilterTagList.Select.Request) {
        
        guard productCategories.indices.contains(request.index) else { return }
        
        let categoryId = productCategories[request.index].getId()
        worker.select(categoryId: categoryId, selectedProductCategories: selectedProductCategories) { selectedProductCategories in
            self.selectedProductCategories = selectedProductCategories
            let response = MatchFilterTagList.Select.Response(
                categories: self.productCategories,
                selectedProductCategories: selectedProductCategories
            )
            self.presenter?.select(response: response)
        }
        
    }
    
    
    // Handler save
    func save(request: MatchFilterTagList.Save.Request) {
        
        worker.save(ids: selectedProductCategories, productCategories: productCategories) {
            let response = MatchFilterTagList.Save.Response()
            self.presenter?.save(response: response)
        }
        
    }
    
    
}
