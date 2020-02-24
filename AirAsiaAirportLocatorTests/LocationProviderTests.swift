//
//  LocationProviderTests.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import AirAsiaAirportLocator

class LocationProviderTests: QuickSpec {

    override func spec() {

        describe("Given a LocationProvider") {

            context("When it's started with LocationManager", closure: {

                // Arrange
                let mockLocationManager = MockLocationManager()
                let mockLocationObservable = MockLocationObservable()
                let locationProvider: LocationProvidable = LocationProvider(locationManager: mockLocationManager)

                beforeEach {
                    mockLocationManager.callCount = 0
                }
                
                it("then starts location updates", closure: {
                    locationProvider.setListener(listener: mockLocationObservable)
                    // Act
                    locationProvider.startLocationUpdates()
                    //Assert
                    expect(mockLocationManager.callCount).toEventually(equal(3))
                    expect(mockLocationObservable.coordinates).toEventuallyNot(beNil())
                    expect(mockLocationObservable.coordinates?.0).toEventually(equal(12.909))
                    expect(mockLocationObservable.coordinates?.1).toEventually(equal(77.698))
                })

            })

        }
    }
}
