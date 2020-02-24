//
//  LocationMocks.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import MapKit
@testable import AirAsiaAirportLocator

// MARK: - Location Provider Mock
class MockLocationProvider: LocationProvidable {
    var listener: LocationObservable?

    func setListener(listener: LocationObservable) {
        self.listener = listener
    }

    func startLocationUpdates() {
        listener?.setCurrentLocation(latitude: 12.909, longitude: 77.698)
    }

    func getCurrentLocation() -> (Double, Double) {
        return (12.909, 77.698)
    }
}

// MARK: - Location Observable Mock
class MockLocationObservable: LocationObservable {
    internal var coordinates: (Double, Double)?
    func setCurrentLocation(latitude: Double, longitude: Double) {
        coordinates = (latitude, longitude)
    }
}

// MARK: - Location Manager Mock
class MockLocationManager: LocationManagerConfigurable {
    internal var callCount = 0
    fileprivate var delegate: LocationProvider?

    func setDelegate(to instance: CLLocationManagerDelegate?) {
        callCount += 1
        delegate = instance as? LocationProvider
    }

    func setDesiredAccuracy(to accuracy: Double) {
        callCount += 1
    }

    func requestAlwaysAuthorization() {
    }
    
    func startUpdatingLocation() {
        callCount += 1
        updateLocation()
    }
    func updateLocation() {
        let mockLocation = CLLocation(latitude: CLLocationDegrees(12.909), longitude: CLLocationDegrees(77.698))
        let mockLocationManager = CLLocationManager()
        delegate?.locationManager(mockLocationManager, didUpdateLocations: [mockLocation])
    }
}
