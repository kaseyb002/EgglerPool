import Foundation

struct Ride {
    let customer: User
    let timeslot: Timeslot
    let pickupLocation: Location
    let destination: Location
    let notes: String
    let status: Status
    
    enum Status {
        case booked
        case started
        case pickedUp
        case arrived
        case cancelled
    }
}
