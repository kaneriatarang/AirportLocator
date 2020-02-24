//
//  MapViewModelTests.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import XCTest
import Quick
import Nimble
import CoreLocation
@testable import AirAsiaAirportLocator


class MapViewModelTests: QuickSpec {

    override func spec() {

        describe("Given a MapViewModel") {

            var viewModel: MapViewModel<MocMapViewController>?

            beforeEach {

                let mockLocationProvider = MockLocationProvider()
                let mockRequest = MockRequestManager()
                mockRequest.getAirportResult = .success(payload: AirportResponse.with()!)
                let mockViewController = MocMapViewController()
                viewModel =
                    MapViewModel(locationProvider: mockLocationProvider,
                                         requestManager: mockRequest,
                                         listener:mockViewController)
            }

            it("get current location", closure: {
                if let (lat, lon) = viewModel?.getCurrentLocation() {
                    expect(lat).to(equal(12.909))
                    expect(lon).to(equal(77.698))
                }
            })

            it("should get all amenities in range", closure: {

                viewModel?.getAirports()

                //Assert
                expect(viewModel?.airportLocationList).toEventuallyNot(beEmpty())

                expect(viewModel?.airportLocationList.first?.id).toEventuallyNot(beEmpty())
                expect(viewModel?.airportLocationList.first?.id).toEventually(equal("vobl"))
                expect(viewModel?.airportLocationList.first?.place.name).toEventually(equal("Bengaluru International Airport"))

                expect(viewModel?.airportLocationList.first?.loc.lat).toEventuallyNot(equal(0))
                expect(viewModel?.airportLocationList.first?.loc.long).toEventuallyNot(equal(0))
            })
        }
    }
}
