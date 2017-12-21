import Foundation

extension Date {
    
    func string(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        return dateWithHoursAdded
    }
    
    func addMinutes(_ minutesToAdd: Int) -> Date {
        let secondsInMinutes: TimeInterval = Double(minutesToAdd) * 60
        let dateWithMinutesAdded: Date = self.addingTimeInterval(secondsInMinutes)
        
        return dateWithMinutesAdded
    }
    
    var startOfDay: Date {
        return Calendar(identifier: .gregorian).startOfDay(for: self)
    }
}
