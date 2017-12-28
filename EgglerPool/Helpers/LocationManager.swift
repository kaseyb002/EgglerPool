import MapKit

protocol LocationManager: CLLocationManagerDelegate {
    var locationManager: CLLocationManager { get set }
}

extension LocationManager {
    
    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}
