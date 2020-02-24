//
//  AirportLocation.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 22/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation
import MapKit
import Contacts

// Airport Location Model
class AirportLocation: NSObject, Codable {

    let id: String
    let loc: Location
    let place: Place
    let relativeTo: RelativeTo

}

// Airport Location MKAnnotion for MAP Pin
extension AirportLocation: MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(loc.lat), longitude: CLLocationDegrees(loc.long))
    }

    var title: String? {
        return place.name
    }

    var subtitle: String? {
        return place.city
    }

    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: String(relativeTo.distanceKM)]
        let mapCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(loc.lat), longitude: CLLocationDegrees(loc.long))
        let placemark = MKPlacemark(coordinate: mapCoordinates, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
