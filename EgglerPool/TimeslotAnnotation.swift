import Foundation
import MapKit

class TimeslotAnnotation: MKPointAnnotation {
    init(coord: CLLocationCoordinate2D, price: Int, infoMsg: String) {
        super.init()
        self.coordinate = coord
        self.title = Int(price).currency
        self.subtitle = infoMsg
    }
}
