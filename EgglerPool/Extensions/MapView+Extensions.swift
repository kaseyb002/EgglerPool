import MapKit

extension MKMapView {
    
    func moveTo(location: CLLocationCoordinate2D, metersZoomed: Double = 10) {
        let region = MKCoordinateRegionMakeWithDistance(location, metersZoomed, metersZoomed)
        region.center.printLatLng()
        setRegion(region, animated: true)
    }
}
