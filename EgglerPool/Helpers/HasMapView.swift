import MapKit

//this is to avoid the need of exposing the entire mapview to parent VCs
protocol HasMapView {
    var mapView: MKMapView! { get set }
}

extension HasMapView {
    var center: CLLocationCoordinate2D { return mapView.centerCoordinate }
}
