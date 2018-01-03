import UIKit
import MapKit

struct Timeslot {
    let driver: User
    let pickupArea: [CircleArea]
    let destinationArea: [CircleArea]
    let timeWindow: TimeWindow//force 15 minute time window
    let price: Double
    let notes: String?
}
