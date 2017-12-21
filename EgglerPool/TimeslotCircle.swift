import MapKit

class TimeslotCircle: MKCircle {
    var price: Int?
    var type: CircleType = .main
}

enum CircleType {
    case main
    case other
}
