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

enum LatLngDistance: Double {
    case countryLevel      = 1.0
    case largeCityLevel    = 0.1
    case townLevel         = 0.01
    case neighborhoodLevel = 0.005
    case farmFieldLevel    = 0.001
    case treeLevel         = 0.0001
}
