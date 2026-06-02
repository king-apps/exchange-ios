import UIKit


protocol MatchFilterPresentationLogic {
    func load(response: MatchFilter.Load.Response)
    func fetch(response: MatchFilter.Fetch.Response)
    func save(response: MatchFilter.Save.Response)
}


class MatchFilterPresenter: MatchFilterPresentationLogic {
  
    
    // Var's
    weak var viewController: MatchFilterDisplayLogic?
  
    
    // Handler load
    func load(response: MatchFilter.Load.Response) {
        
        let viewModel = MatchFilter.Load.ViewModel()
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler fetch
    func fetch(response: MatchFilter.Fetch.Response) {
        
        var rows = [MainTableRow]()
        let localConfig = response.localConfig
        let remoteConfig = response.remoteConfig
        
        // Distance
        rows.append(
            .inputSlider(
                .init(
                    title: "Match.Filter.Distance.Title".localized,
                    value: Float(localConfig.getRadius()),
                    valueSufix: "App.Radius.Code".localized,
                    minimumValue: Float(remoteConfig.getMatchFilterRadiusMin()),
                    maximumValue: Float(remoteConfig.getMatchFilterRadiusMax()),
                    identifier: .radius
                )
            )
        )
        // Categories
        rows.append(
            .inputSelect(
                .init(
                    title: "StickerFilter.Categories.Title".localized,
                    placeholder:
                    localConfig.getCategories().count > 0
                    ? "StickerFilter.Categories.Value".localized.replacingOccurrences(of: "{$0}", with: "\(localConfig.getCategories().count)")
                    : "StickerFilter.Categories.Placeholder".localized
                    ,
                    value: "",
                    count: "", // config.getCategories().count > 0 ? "\(config.getCategories().count)" : "",
                    iconLeft: localConfig.getCategories().count > 0
                    ? .checkCircle
                    : .circle
                    ,
                    iconRight: .arrowRight,
                    isEnabled: true,
                    identifier: .category
                )
            )
        )
        
        let viewModel = MatchFilter.Fetch.ViewModel(rows: rows)
        viewController?.onFetch(viewModel: viewModel)
        
    }
    
    
    // Handler save
    func save(response: MatchFilter.Save.Response) {
        let viewModel = MatchFilter.Save.ViewModel()
        viewController?.onSave(viewModel: viewModel)
    }
    
    
}
