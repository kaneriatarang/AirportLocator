//
//  AirportResponseTest.swift
//  AirAsiaAirportLocatorTests
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import XCTest
@testable import AirAsiaAirportLocator

class AirportResponseTest: XCTestCase {

    var jsonData: Data?

    override func setUp() {

        let testString = """
               {
                 "success": true,
                 "error": null,
                 "response": [
                   {
                     "id": "vobl",
                     "loc": {
                       "lat": 13.1978998184,
                       "long": 77.7062988281
                     },
                     "place": {
                       "name": "Bengaluru International Airport",
                       "city": "Bangalore",
                       "state": "",
                       "stateFull": "",
                       "country": "IN",
                       "countryFull": "India",
                       "region": "",
                       "regionFull": "",
                       "continent": "as",
                       "continentFull": "Asia"
                     },
                     "profile": {
                       "id": "vobl",
                       "iata": "blr",
                       "local": "",
                       "type": "la",
                       "typeENG": "large airport",
                       "elevFT": 3000,
                       "elevM": 914.4,
                       "pop": null,
                       "tz": "Asia/Kolkata",
                       "tzname": "IST",
                       "tzoffset": 19800,
                       "isDST": false,
                       "wxzone": null,
                       "firezone": null,
                       "fips": null,
                       "countyid": null
                     },
                     "relativeTo": {
                       "lat": 13.040284,
                       "long": 77.620957,
                       "bearing": 28,
                       "bearingENG": "NNE",
                       "distanceKM": 19.814,
                       "distanceMI": 12.312
                     }
                   }
                 ]
               }
               """

        jsonData = Data(testString.utf8)

    }

    override func tearDown() {
        jsonData = nil
    }

    func testContactObjectParsing() {
        let response = try? JSONDecoder().decode(AirportResponse.self, from: jsonData!)
        XCTAssertNotNil(response)
    }
}

