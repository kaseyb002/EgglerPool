import MapKit

struct Location {
    let coordinate: CLLocationCoordinate2D
    let streetAddress: String?
    let city: String?
    let state: String?
    let formattedAddress: String
    let name: String
    let googlePlaceId: String
}
