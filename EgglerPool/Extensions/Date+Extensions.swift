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
    
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    var hour: Int {
        let calendar = Calendar.current
        let comp = (calendar as NSCalendar).components([.hour], from: self)
        return comp.hour!
    }
    
    var minute: Int {
        let calendar = Calendar.current
        let comp = (calendar as NSCalendar).components([.minute], from: self)
        return comp.minute!
    }
    
    /**
     Keeps same hour and minute but changes day
     */
    func update(toDay day: Date) -> Date {
        let hours = hoursFrom(startOfDay)
        let minutes = minutesFrom(startOfDay.addHours(hours))
        return day.addHours(hours).addMinutes(minutes)
    }
}
