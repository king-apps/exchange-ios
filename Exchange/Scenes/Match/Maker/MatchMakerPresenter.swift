import UIKit


protocol MatchMakerPresentationLogic {
    func load(response: MatchMaker.Load.Response)
    func location(response: MatchMaker.Location.Response)
    func notification(response: MatchMaker.Notification.Response)
    func tracking(response: MatchMaker.Tracking.Response)
    func search(response: MatchMaker.Search.Response)
    func detail(response: MatchMaker.Detail.Response)
    func intention(response: MatchMaker.Intention.Response)
    func countMyProducts(response: MatchMaker.CountMyProducts.Response)
    func ad(response: MatchMaker.Ad.Response)
    func superLike(response: MatchMaker.SuperLike.Response)
    func boostProfile(response: MatchMaker.BoostProfile.Response)
    func boostProfileStatus(response: MatchMaker.BoostProfileStatus.Response)
}


class MatchMakerPresenter: MatchMakerPresentationLogic {
  
    
    // Var's
    weak var viewController: MatchMakerDisplayLogic?
  
    
    // Handler load
    func load(response: MatchMaker.Load.Response) {
        
        let viewModel = MatchMaker.Load.ViewModel(
            radius: response.radius,
            categories: response.categories
        )
        viewController?.onLoad(viewModel: viewModel)
        
    }
    
    
    // Handler location
    func location(response: MatchMaker.Location.Response) {
        
        if let error = response.error {
            viewController?.onLocationError(error: error)
        }
        else {
            let viewModel = MatchMaker.Location.ViewModel()
            viewController?.onLocation(viewModel: viewModel)
        }
    }
    
    
    // Handler notification
    func notification(response: MatchMaker.Notification.Response) {
        
        let granted = response.granted
        let viewModel = MatchMaker.Notification.ViewModel(granted: granted)
        viewController?.onNotification(viewModel: viewModel)
        
    }
    
    
    // Handler tracking
    func tracking(response: MatchMaker.Tracking.Response) {
        
        let viewModel = MatchMaker.Tracking.ViewModel(authorized: response.authorized)
        viewController?.onTracking(viewModel: viewModel)
        
    }
    
    
    // Handler search
    func search(response: MatchMaker.Search.Response) {
        
        if let error = response.error {
            viewController?.onSearchError(error: error)
        }
        else {
            var cards = [CardModel]()
            
            if let products = response.list {
                for product in products {
                    let url = product.images.first?.getUrl() ?? ""
                    
                    var distance = "\(product.getDistance()) "+"App.Radius.Code".localized
                    if product.getDistance() <= 0 {
                        distance = "? "+"App.Radius.Code".localized
                    }
                    
                    let card = CardModel(
                        id: product.getId(),
                        url: url,
                        name: product.getTitle(),
                        distance: distance
                    )
                    cards.append(card)
                }
            }
            

            let viewModel = MatchMaker.Search.ViewModel(cards: cards)
            viewController?.onSearch(viewModel: viewModel)
        }
    }
    
    
    // Handler detail
    func detail(response: MatchMaker.Detail.Response) {
        
        if let _ = response.product {
            let viewModel = MatchMaker.Detail.ViewModel()
            viewController?.onDetail(viewModel: viewModel)
        }
    }
    
    
    // Handler intention
    func intention(response: MatchMaker.Intention.Response) {
        
        if let intention = response.intention {
            let match = intention.getMatch()
            let viewModel = MatchMaker.Intention.ViewModel(match: match)
            viewController?.onIntention(viewModel: viewModel)
        }
        else {
            if let error = response.error {
                viewController?.onIntentionError(error: error)
            }
        }
        
    }
    
    
    // Handler count my products
    func countMyProducts(response: MatchMaker.CountMyProducts.Response) {
        
        let myProducts = response.myProducts ?? 0
        let viewModel = MatchMaker.CountMyProducts.ViewModel(myProducts: myProducts)
        viewController?.onCountMyProducts(viewModel: viewModel)
        
    }
    
    
    // Handler ad
    func ad(response: MatchMaker.Ad.Response) {
        
        if let adUnitId = response.adUnitId {
            let viewModel = MatchMaker.Ad.ViewModel(adUnitId: adUnitId)
            viewController?.onAd(viewModel: viewModel)
        }
        
    }
    
    
    // Handler super like
    func superLike(response: MatchMaker.SuperLike.Response) {
        
        if let _ = response.product {
            let viewModel = MatchMaker.SuperLike.ViewModel()
            viewController?.onSuperLike(viewModel: viewModel)
        }
        
    }
    
    
    // Handler boost profile
    func boostProfile(response: MatchMaker.BoostProfile.Response) {
        
        if let error = response.error {
            viewController?.onBoostProfile(error: error)
        }
        else {
            let viewModel = MatchMaker.BoostProfile.ViewModel()
            viewController?.onBoostProfile(viewModel: viewModel)
        }
        
    }
    func boostProfileStatus(response: MatchMaker.BoostProfileStatus.Response) {
        let viewModel = MatchMaker.BoostProfileStatus.ViewModel(isActive: response.isActive)
        viewController?.onBoostProfileStatus(viewModel: viewModel)
    }
    
    
}
