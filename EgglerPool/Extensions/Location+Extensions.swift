import Foundation

extension Location {
    
    var cityState: String? {
        if let city = city, state == nil { return city }
        if let state = state, city == nil {return state }
        if let city = city, let state = state { return city + ", " + state }
        return nil
    }
}
