import Foundation

struct Defaults {
    static let defaultIncrement = 15//minutes
    static let startDay = Date().startOfDay.addDays(1)
    
    static let lastDay = Defaults.startDay.addDays(60)
}
