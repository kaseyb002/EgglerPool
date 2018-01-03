import Foundation

extension Int {
    
    var currency: String {
        return "$\(self)"
    }
    
    func isBetween(_ min: Int, and max: Int) -> Bool {
        return self >= min && self <= max
    }
}

var randomBool: Bool { return randomBetween(min: 1, max: 10) > 5 }

var randomNegative: Int { return randomBool ? 1 : -1 }

//MARK: - Getting Random Numbers
func randomBetween(min: UInt32, max: UInt32) -> UInt32 {//from SO
    return arc4random_uniform(max - min) + min
}

func randomBetween(min: Int, max: Int) -> Int {
    return Int(randomBetween(min: UInt32(min), max: UInt32(max)))
}
