import Foundation
import MapKit

struct MockData {
    
    static let spanishFork: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.114249, longitude: -111.646807)
    static let driver1 = User(email: "jake@gmail.com", firstName: "Jake", lastName: "Smith")
    static let driver2 = User(email: "tim@gmail.com", firstName: "Tim", lastName: "Willis")
    static let notes: [String] = [
        "No farting in the car.",
        "Plenty of room for luggage!",
        "I prefer no chit-chat.",
        "Water bottles included!",
        "Shotgun controls the radio.",
        "My car's A/C is broken, just fyi.",
    ]
    static var randomNote: String {
        return notes[Int(randomBetween(min: 0, max: UInt32(notes.count - 1)))]
    }
    static func randomPrice(min: Double, max: Double) -> Double {
        return Double(randomBetween(min: UInt32(min), max: UInt32(max)))
    }
    static func randomTimeWindow(earliest: Date, latest: Date) -> TimeWindow {
        let hour = randomBetween(min: UInt32(earliest.hour), max: UInt32(latest.hour))
        let minutesMultiple = randomBetween(min: 0, max: UInt32(latest.minute / 15))
        let start = earliest.startOfDay.addHours(Int(hour)).addMinutes(Int(minutesMultiple * 15))
        let end = start.addMinutes(15)
        return TimeWindow(startTime: start, endTime: end)
    }
    static func makeTimeWindows(earliest: Date, latest: Date, randomlyInclude: Bool = false) -> [TimeWindow] {
        var timeWindows = [TimeWindow]()
        var current = earliest
        while current.addMinutes(15) <= latest {
            let timeWindow = TimeWindow(startTime: current, endTime: current.addMinutes(15))
            if randomlyInclude {
                if randomBool { timeWindows.append(timeWindow) }
            } else {
                timeWindows.append(timeWindow)
            }
            current = current.addMinutes(15)
        }
        return timeWindows
    }
    
    static var randomDriver: User { return randomBool ? driver1 : driver2 }
    static var mockTimeWindow: TimeWindow {
        return TimeWindow(startTime: Date().addDays(1).startOfDay.addHours(7),
                          endTime: Date().addDays(1).startOfDay.addHours(7).addMinutes(15))
    }
    static let minPrice: Double = 5
    static let maxPrice: Double = 10
    
    static func generateMockTimeslots(coordinate: CLLocationCoordinate2D,
                                      count: Int,
                                      driver: User = randomDriver,
                                      timeWindow: TimeWindow = mockTimeWindow,
                                      minPrice: Double = minPrice,
                                      maxPrice: Double = maxPrice,
                                      notes: String = randomNote) -> [Timeslot] {
        
        var timeslots = [Timeslot]()
        for _ in 0...count {
            timeslots.append(Timeslot(driver: randomDriver,
                                      pickupArea: makeRandomCircleAreas(center: coordinate, latLngDistance: .neighborhoodLevel),
                                      destinationArea: makeRandomCircleAreas(center: coordinate, latLngDistance: .neighborhoodLevel),
                                      timeWindow: timeWindow,
                                      price: randomPrice(min: minPrice, max: maxPrice),
                                      notes: randomNote))
        }
        return timeslots
    }
    
    static func makeRandomCircleAreas(center: CLLocationCoordinate2D,
                                      latLngDistance: LatLngDistance) -> [CircleArea] {
        var coords = [CircleArea]()
        for _ in 0...randomBetween(min: 1, max: 3) {
            //adding random lat + lng to spread out circles
            let latPlus = Double(randomBetween(min: 0, max: 10)) * latLngDistance.rawValue * Double(randomNegative)
            let lngPlus = Double(randomBetween(min: 0, max: 10)) * latLngDistance.rawValue * Double(randomNegative)
            let radius = Double(randomBetween(min: 500, max: 3000))
            let circleArea = CircleArea(coordinate: center.adjust(latBy: latPlus, longBy: lngPlus), radius: radius)
            coords.append(circleArea)
        }
        return coords
    }
    
    static func makeRandomTimeslots(inTimeWindow timeWindow: TimeWindow,
                                    pickupSpot: CLLocationCoordinate2D,
                                    count: Int,
                                    minInEachWindow: Int = 1,
                                    maxInEachWindow: Int = 5) -> [TimeslotsInWindow] {
        var timeslotsInWindows = [TimeslotsInWindow]()
        
        let timeWindows = makeTimeWindows(earliest: timeWindow.startTime,
                                          latest: timeWindow.endTime,
                                          randomlyInclude: true)
        
        for timeWindow in timeWindows {
            let timeslots = generateMockTimeslots(coordinate: pickupSpot,
                                                  count: randomBetween(min: minInEachWindow, max: maxInEachWindow),
                                                  timeWindow: timeWindow)
            let timeslotsInTimeWindow = TimeslotsInWindow(timeWindow: timeWindow, timeslots: timeslots)
            timeslotsInWindows.append(timeslotsInTimeWindow)
        }
        
        return timeslotsInWindows.sorted { $0.timeWindow.startTime < $1.timeWindow.endTime }
    }
}
