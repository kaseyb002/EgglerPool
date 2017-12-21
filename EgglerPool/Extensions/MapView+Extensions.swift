import MapKit

extension MKMapView {
    
    func moveTo(location: CLLocationCoordinate2D, spanDegrees: Double = 0.3) {
        let span = MKCoordinateSpan(latitudeDelta: spanDegrees,
                                    longitudeDelta: spanDegrees)
        let region = MKCoordinateRegion(center: location, span: span)
        setRegion(region, animated: true)
    }
}
