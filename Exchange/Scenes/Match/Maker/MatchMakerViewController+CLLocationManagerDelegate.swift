import CoreLocation
import Foundation


extension MatchMakerViewController : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else {
            handlerNeedLocation()
            /*
            self.page = 0
            self.notification()
            self.search()
            */
        }
        
        /*
         if status == .denied {
             print("LOCATION DENIED")
         }
        if status == .notDetermined {
            print("LOCATION NOT DETERMINED")
        }
         */
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let coordinate = manager.location?.coordinate {
            let latitude = Double(coordinate.latitude)
            let longitude = Double(coordinate.longitude)
            
            location(latitude: latitude, longitude: longitude)
            manager.stopUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if #available(iOS 14, *) {
            if manager.authorizationStatus == .denied {
                handlerNeedLocation()
            }
            else {
                if manager.authorizationStatus != .notDetermined {
                    self.page = 0
                    notification()
                }
                else {
                    self.page = 0
                    notification()
                }
            }
        }
        else {
            self.page = 0
            notification()
        }
        
        
        
    }
    
    
}
