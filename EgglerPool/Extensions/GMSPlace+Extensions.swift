import GooglePlaces

extension GMSPlace {
    
    var location: Location? {
        addressComponents?.forEach {
            print("type: " + $0.type)
            print("name: " + $0.name)
        }
        guard let streetName = addressComponents?.filter({ $0.type == "route" }).first?.name else { return nil }
        guard let streetNumber = addressComponents?.filter({ $0.type == "street_number" }).first?.name else { return nil }
        guard let city = addressComponents?.filter({ $0.type == "administrative_area_level_3" }).first?.name else { return nil }
        guard let state = addressComponents?.filter({ $0.type == "administrative_area_level_1" }).first?.name else { return nil }
        return Location(coordinate: coordinate,
                        streetAddress: streetNumber + " " + streetName,
                        city: city,
                        state: state,
                        name: name,
                        googlePlaceId: placeID)
    }
}
