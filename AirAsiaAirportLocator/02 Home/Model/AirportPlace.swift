//
//  AirportPlace.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

// Airport Location Model holds Latitude & Longitude
class Location: Codable {

    let lat: Double
    let long: Double

}

// Airport Place Model holds location name and Details
class Place: Codable {

    let name: String
    let city: String?
    let state: String?
    let country: String?

}

// Airport RelativeTo Model holds current location and distance to Airport location
class RelativeTo: Codable {

    let lat: Double
    let long: Double
    let bearing: Int
    let distanceKM: Double
    let distanceMI: Double

}
