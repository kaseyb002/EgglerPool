import Foundation

extension Double {
    
    var oneDecimalPlace: String {
        return decimalPlaces(1)
    }
    
    var twoDecimalPlaces: String {
        return decimalPlaces(2)
    }
    
    var threeDecimalPlaces: String {
        return decimalPlaces(3)
    }
    
    func decimalPlaces(_ digits: Int) -> String {
        return String(format: "%.0\(digits)f", self)
    }
}
