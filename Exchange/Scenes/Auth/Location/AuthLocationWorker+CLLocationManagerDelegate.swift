import UIKit
import CoreLocation


extension AuthLocationWorker: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus(status)
    }
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationCompletion?(true)
            locationCompletion = nil
        case .denied, .restricted:
            locationCompletion?(false)
            locationCompletion = nil
        case .notDetermined:
            break
        @unknown default:
            locationCompletion?(false)
            locationCompletion = nil
        }
    }
    
}
