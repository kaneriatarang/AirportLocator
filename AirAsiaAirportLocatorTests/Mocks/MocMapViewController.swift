//
//  MocMapViewController.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation
@testable import AirAsiaAirportLocator

class MocMapViewController: MapViewModelObservable {
    func centerMapToCurrentLocation(latitude: Double, longitude: Double) {

    }

    func setCurrentLocation(latitude: Double, longitude: Double) {}
    func addLocationToMap(location: AirportLocation) {}
    typealias Location = AirportLocation
}
