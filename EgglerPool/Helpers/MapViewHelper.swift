import Foundation

enum MapZoomLevel: Double {
    case houseLevel        = 10//meters
    case streetLevel       = 100
    case neighborhoodLevel = 1000
    case cityLevel         = 10000
    case countyLevel       = 100000
    case stateLevel        = 1000000
    case regionLevel       = 10000000
    case countryLevel      = 100000000
}
