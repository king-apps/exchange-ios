import UIKit


protocol MatchFilterTagListPresentationLogic {
    func load(response: MatchFilterTagList.Load.Response)
    func select(response: MatchFilterTagList.Select.Response)
    func save(response: MatchFilterTagList.Save.Response)
}


class MatchFilterTagListPresenter: MatchFilterTagListPresentationLogic {
  
    
    // Var's
    weak var viewController: MatchFilterTagListDisplayLogic?
  
    
    // Handler load
    func load(response: MatchFilterTagList.Load.Response) {
        
        if let error = response.error {
            viewController?.onLoadError(error: error)
        }
        else {
            if let categories = response.categories {
                let list = buildRows(
                    categories: categories,
                    selectedProductCategories: response.selectedProductCategories
                )
                let viewModel = MatchFilterTagList.Load.ViewModel(list: list)
                viewController?.onLoad(viewModel: viewModel)
            }
            else {
                let error = "App.Error.500".localized
                viewController?.onLoadError(error: error)
            }
        }
        
        
        
    }


    // Handler select
    func select(response: MatchFilterTagList.Select.Response) {
        
        let list = buildRows(
            categories: response.categories,
            selectedProductCategories: response.selectedProductCategories
        )
        let viewModel = MatchFilterTagList.Select.ViewModel(list: list)
        viewController?.onSelect(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: MatchFilterTagList.Save.Response) {
        
        let viewModel = MatchFilterTagList.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
        
    }


    // Build rows
    private func buildRows(categories: [ProductCategory], selectedProductCategories: [Int]) -> [MainTableRow] {
        
        var list = [MainTableRow]()
        
        if categories.count > 0 {
            for category in categories {
                let isSelected = selectedProductCategories.contains(category.getId())
                
                list.append(
                    .default(
                        .init(
                            iconLeft: .none,
                            iconLeftUrl: category.getLogo(),
                            iconRight: isSelected ? .checkCircle : .circle,
                            title: category.getName(),
                            titleNumberOfLines: nil,
                            description: category.getCode(),
                            style: isSelected ? .selected : .normal,
                            identifier: .generic,
                            tag: nil
                        )
                    )
                )
            }
        }
        else {
            list.append(
                .empty(
                    .init(
                        icon: .tag,
                        text: "Match.Filter.Tags.Empty".localized
                    )
                )
            )
        }
        
        return list
        
    }
    
}
