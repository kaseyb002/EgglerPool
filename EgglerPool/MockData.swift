import Foundation
import MapKit

struct MockData {
    
    static let driver1 = User(email: "jake@gmail.com", firstName: "Jake", lastName: "Smith")
    static let driver2 = User(email: "tim@gmail.com", firstName: "Tim", lastName: "Willis")
    static let notes: [String] = [
        "No farting in the car.",
        "Plenty of room for luggage!",
        "I prefer no chit-chat.",
        "Water bottles included!",
        "Shotgun controls the radio.",
        "My car's A/C is broken, just fyi",
    ]
    static var randomNote: String {
        return notes[Int(randomBetween(min: 0, max: UInt32(notes.count - 1)))]
    }
    static var randomPrice: Double {
        return Double(randomBetween(min: minPrice, max: maxPrice))
    }
    static var randomTimeWindow: TimeWindow {
        let start = Date().startOfDay.addHours(7).addMinutes(15)
        let end = start.addMinutes(45)
        return TimeWindow(startTime: start, endTime: end)
    }
    static var randomDriver: User { return randomBool ? driver1 : driver2 }
    static let minPrice: UInt32 = 3
    static let maxPrice: UInt32 = 10
    
    static func generateMockTimeslots(location: CLLocationCoordinate2D, count: Int) -> [Timeslot] {
        var timeslots = [Timeslot]()
        [0...count].forEach { _ in
            timeslots.append(Timeslot(driver: randomDriver,
                                      pickupArea: makeCircleAreas(center: location),
                                      destinationArea: makeCircleAreas(center: location),
                                      timeWindow: randomTimeWindow,
                                      price: randomPrice,
                                      notes: randomNote))
        }
        return timeslots
    }
    
    static func makeCircleAreas(center: CLLocationCoordinate2D) -> [CircleArea] {
        var coords = [CircleArea]()
        for _ in 0...2 {
            let latPlus = Double(randomBetween(min: 0, max: 150))/500 * Double(randomNegative)
            let lngPlus = Double(randomBetween(min: 0, max: 150))/500 * Double(randomNegative)
            let radius = Double(randomBetween(min: 1000, max: 10000))
            let circleArea = CircleArea(coordinate: center.adjust(latBy: latPlus, longBy: lngPlus), radius: radius)
            coords.append(circleArea)
        }
        return coords
    }
}
