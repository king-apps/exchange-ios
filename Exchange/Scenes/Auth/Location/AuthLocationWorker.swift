import UIKit
import CoreLocation


class AuthLocationWorker: NSObject {
    
    
    // Var's
    private let locationManager = CLLocationManager()
    var locationCompletion: ((_ granted: Bool) -> ())?
    
    
    // Construct
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    
    // Handler load
    func load(completion: @escaping() -> ()) {
        completion()
    }
    
    
    // Handler location
    func location(completion: @escaping(_ granted: Bool) -> ()) {
        
        locationCompletion = completion
        
        guard CLLocationManager.locationServicesEnabled() else {
            completion(false)
            return
        }
        
        let status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    
    // Handler save
    func save(completion: @escaping() -> ()) {
        completion()
    }
    
    
}


