import UIKit


@objc protocol MatchMakerRoutingLogic {
    func routeToFilter(segue: UIStoryboardSegue?)
    func routeToProduct(segue: UIStoryboardSegue?)
    func routeToItsAMatch(segue: UIStoryboardSegue?)
    func routeToSuperLike(segue: UIStoryboardSegue?)
    
    func routeToBoostProfile()
    func routeToBoostProfileIsActive()
    func routeToSuperLikeSuccess()
    func routeToDenunciate()
    func routeToDenunciateSuccess()
    func routeToAddProduct()
    func routeToNeedLocation()
}


protocol MatchMakerDataPassing {
    var dataStore: MatchMakerDataStore? { get }
}


class MatchMakerRouter: NSObject, MatchMakerRoutingLogic, MatchMakerDataPassing {
    
    
    // Var's
    weak var viewController: MatchMakerViewController?
    var dataStore: MatchMakerDataStore?
  
    
    // Routing
    func routeToFilter(segue: UIStoryboardSegue?) {
        if let segue = segue, let navigationVC = segue.destination as? UINavigationController {
            if let sheet = navigationVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            if let destinationVC = navigationVC.children.first as? MatchFilterViewController {
                destinationVC.delegate = viewController
            }
        }
    }
    func routeToProduct(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ProductDetailViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToProduct(source: dataStore!, destination: &destinationDS)
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
        }
    }
    func routeToItsAMatch(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? ItsAMatchViewController {
            var destinationDS = destinationVC.router!.dataStore!
            destinationVC.delegate = viewController
            passDataToItsAMatch(source: dataStore!, destination: &destinationDS)
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
        }
    }
    func routeToSuperLike(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? SuperLikeViewController {
            
            if let sheet = destinationVC.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            destinationVC.delegate = viewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSuperLike(destination: &destinationDS)
        }
    }
    func routeToBoostProfile() {
        routeToKnowMore(.boostProfile)
    }
    func routeToBoostProfileIsActive() {
        routeToKnowMore(.boostProfileIsActive)
    }
    func routeToSuperLikeSuccess() {
        routeToKnowMore(.superLikeSuccess)
    }
    func routeToDenunciate() {
        routeToKnowMore(.denunciate)
    }
    func routeToDenunciateSuccess() {
        routeToKnowMore(.denunciateSuccess)
    }
    func routeToAddProduct() {
        routeToKnowMore(.matchMakerAddProduct)
    }
    func routeToNeedLocation() {
        routeToKnowMore(.matchMakerNeedLocation)
    }
    private func routeToKnowMore(_ option: KnowMoreOption) {
        if let destinationVC = UIStoryboard(name: "KnowMore", bundle: nil).instantiateInitialViewController() as? KnowMoreViewController {
            destinationVC.modalPresentationStyle = .pageSheet
            
            if let sheet = destinationVC.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    let detent = UISheetPresentationController.Detent.custom(
                        identifier: .init("KnowMoreContent")
                    ) { [weak destinationVC] context in
                        destinationVC?.preferredSheetHeight(maximumHeight: context.maximumDetentValue)
                    }
                    sheet.detents = [detent]
                    destinationVC.sheetHeightDidChange = { [weak sheet] in
                        sheet?.invalidateDetents()
                    }
                }
                else {
                    sheet.detents = [.medium()]
                }
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            
            destinationVC.delegate = viewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToKnowMore(option, destination: &destinationDS)
            
            viewController?.present(destinationVC, animated: true)
        }
    }
    
    
    // Passing data
    func passDataToProduct(source: MatchMakerDataStore, destination: inout ProductDetailDataStore) {
        destination.product = source.product
    }
    func passDataToItsAMatch(source: MatchMakerDataStore, destination: inout ItsAMatchDataStore) {
        destination.productIntention = source.productIntention
    }
    func passDataToSuperLike(destination: inout SuperLikeDataStore) {
        destination.product = dataStore?.product
    }
    private func passDataToKnowMore(_ option: KnowMoreOption, destination: inout KnowMoreDataStore) {
        destination.knowMoreOption = option
    }
    
    
}
