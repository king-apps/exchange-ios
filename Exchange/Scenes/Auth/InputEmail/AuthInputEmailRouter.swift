import UIKit


@objc protocol AuthInputEmailRoutingLogic {
    func routeToSuccess(segue: UIStoryboardSegue?)
    func routeToNext(segue: UIStoryboardSegue?)
}


protocol AuthInputEmailDataPassing {
    var dataStore: AuthInputEmailDataStore? { get }
}


class AuthInputEmailRouter: NSObject, AuthInputEmailRoutingLogic, AuthInputEmailDataPassing {
    
    
    // Var's
    weak var viewController: AuthInputEmailViewController?
    var dataStore: AuthInputEmailDataStore?
  
    
    // Routing
    func routeToSuccess(segue: UIStoryboardSegue?) {
        if let segue = segue {
            if let destinationVC = segue.destination as? AuthSuccessViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToSuccess(source: dataStore!, destination: &destinationDS)
            }
        }
    }
    func routeToNext(segue: UIStoryboardSegue?) {
        if let segue = segue {
            if let destinationVC = segue.destination as? AuthInputTokenViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToNext(source: dataStore!, destination: &destinationDS)
            }
        }
    }

    
    // Passing data
    func passDataToSuccess(source: AuthInputEmailDataStore, destination: inout AuthSuccessDataStore) {
        
    }
    func passDataToNext(source: AuthInputEmailDataStore, destination: inout AuthInputTokenDataStore) {
        destination.email = source.email
    }

    
}
