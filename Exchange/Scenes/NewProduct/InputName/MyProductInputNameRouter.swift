import UIKit


@objc protocol MyProductInputNameRoutingLogic {
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol MyProductInputNameDataPassing {
    var dataStore: MyProductInputNameDataStore? { get }
}


class MyProductInputNameRouter: NSObject, MyProductInputNameRoutingLogic, MyProductInputNameDataPassing {
    
    
    // Var's
    weak var viewController: MyProductInputNameViewController?
    var dataStore: MyProductInputNameDataStore?
  
    
    // Routing
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue, let destinationVC = segue.destination as? MyProductInputImageViewController {
            var destinationDS = destinationVC.router!.dataStore!
            passDataToInputImage(source: dataStore!, destination: &destinationDS)
        }
    }
    
    
    // Passing data
   
    func passDataToInputImage(source: MyProductInputNameDataStore, destination: inout MyProductInputImageDataStore) {
        destination.product = source.product
    }
    
    
}
