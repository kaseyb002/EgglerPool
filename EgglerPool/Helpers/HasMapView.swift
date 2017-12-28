import MapKit

protocol HasMapView {
    var mapView: MKMapView! { get set }
}

extension HasMapView {
    var center: CLLocationCoordinate2D { return mapView.centerCoordinate }
}
