import GooglePlaces

extension GMSPlace {
    
    var location: Location? {
        let streetAddress: String? = {
            guard let streetName = addressComponents?.filter({ $0.type == "route" }).first?.name else { return nil }
            guard let streetNumber = addressComponents?.filter({ $0.type == "street_number" }).first?.name else { return nil }
            return streetNumber + " " + streetName
        }()
        return Location(coordinate: coordinate,
                        streetAddress: streetAddress,
                        city: addressComponents?.filter({ $0.type == "locality" }).first?.name,
                        state: addressComponents?.filter({ $0.type == "administrative_area_level_1" }).first?.name,
                        formattedAddress: formattedAddress ?? name,
                        name: name,
                        googlePlaceId: placeID)
    }
}
