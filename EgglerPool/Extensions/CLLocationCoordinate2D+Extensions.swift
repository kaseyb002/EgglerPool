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
}
