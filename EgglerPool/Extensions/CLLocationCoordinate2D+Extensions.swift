import MapKit

extension CLLocationCoordinate2D {
    
    func adjust(latBy: Double? = nil, longBy: Double? = nil) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude + (latBy ?? 0.0),
                                      longitude: longitude + (longBy ?? 0.0))
    }
    
    func printLatLng() {
        print("Lat: \(latitude)")
        print("Lng: \(longitude)")
    }
    
    func latLngDisplay(decimalPlaces: Int = 3) -> String {
        return "\(latitude.decimalPlaces(decimalPlaces)), \(longitude.decimalPlaces(decimalPlaces))"
    }
    
    var cllocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
