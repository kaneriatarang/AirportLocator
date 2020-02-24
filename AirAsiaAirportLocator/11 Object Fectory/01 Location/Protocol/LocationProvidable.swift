//
//  LocationProvidable.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 21/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

protocol LocationProvidable {
    var listener: LocationObservable? { get set }
    func setListener(listener: LocationObservable)
    func startLocationUpdates()
    func getCurrentLocation() -> (Double, Double)
}

// To be implemented by the ViewModel
protocol LocationObservable {
    func setCurrentLocation(latitude: Double, longitude: Double)
}
