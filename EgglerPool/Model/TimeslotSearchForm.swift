import Foundation
import GooglePlaces

struct TimeslotSearchForm {
    var destination: GMSPlace?
    var pickupSpot: CLLocationCoordinate2D?
    var earliest: Date?
    var latest: Date?
}

