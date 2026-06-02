import UIKit


protocol MyProductListPresentationLogic {
    func load(response: MyProductList.Load.Response)
    func fetch(response: MyProductList.Fetch.Response)
    func detail(response: MyProductList.Detail.Response)
    func delete(response: MyProductList.Delete.Response)
}


class MyProductListPresenter: MyProductListPresentationLogic {
  
    
    // Var's
    weak var viewController: MyProductListDisplayLogic?
  
    
    // Handler load
    func load(response: MyProductList.Load.Response) {
       
        let viewModel = MyProductList.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
            
    }
    
    
    // Handler fetch
    func fetch(response: MyProductList.Fetch.Response) {
     
        if let error = response.error {
            viewController?.onFetch(error: error)
        }
        else {
            
            var rows = [MainTableRow]()
            var categories: [ProductCategory] = []
            
            if let products = response.products {
                
                // Categories
                for product in products {
                    if !categories.contains(where: { $0.getId() == product.category.getId() }) {
                        categories.append(product.category)
                    }
                }
                
                for category in categories {
                    //rows.append(
                     //   .textHeadingMd(
                    //        .init(
                    //            text: category.getName(),
                    //            align: .left,
                    //            image: category.getLogo()
                    //        )
                    //    )
                   // )
                    rows.append(
                        .textCaption(
                            .init(text: category.getName(), align: .left)
                        )
                    )
                    let filterProducts = products.filter({$0.category.getId() == category.getId()})
                    for product in filterProducts {
                        rows.append(
                            .default(
                                .init(
                                    iconLeft: .none,
                                    iconLeftUrl: product.images.first?.getUrl(),
                                    iconRight: .arrowRight,
                                    title: product.getTitle(),
                                    style: .normal,
                                    identifier: .generic
                                )
                            )
                        )
                    }
                    rows.append(
                        .spacing(
                            .init(size: .xxl)
                        )
                    )
                }
            }
            
            let viewModel = MyProductList.Fetch.ViewModel(rows: rows)
            viewController?.onFetch(viewModel: viewModel)
        }
    }
    
    
    // Handler detail
    func detail(response: MyProductList.Detail.Response) {
        
        if let _ = response.product {
            let viewModel = MyProductList.Detail.ViewModel()
            viewController?.onDetail(viewModel: viewModel)
        }
        
    }
    
    
    // Handler delete
    func delete(response: MyProductList.Delete.Response) {
        
        let viewModel = MyProductList.Delete.ViewModel()
        viewController?.onDelete(viewModel: viewModel)
        
    }
    
}
