//
//  MocRequestManager.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation
@testable import AirAsiaAirportLocator

// MARK: - Request Manager Mock
class MockRequestManager: RequestManager {

    var getAirportResult: RequestManager.GetAirportResult?

    override func getAirportLocations(latitude: Double, longitude:Double, completion: @escaping RequestManager.GetAirportCompletion) {
        completion(getAirportResult!)
    }

}
