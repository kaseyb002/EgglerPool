import MapKit

extension MKMapView {
    
    func moveTo(location: CLLocationCoordinate2D, metersZoomed: Double?) {
        let newRegion: MKCoordinateRegion = {
            guard let metersZoomed = metersZoomed else { return MKCoordinateRegionMake(location, region.span) }
            return MKCoordinateRegionMakeWithDistance(location, metersZoomed, metersZoomed)
        }()
        setRegion(newRegion, animated: true)
    }
}
