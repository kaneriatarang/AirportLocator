//
//  AirportResponse.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

// Airport API Respoase Model
class AirportResponse: Codable {

    let success: Bool
    let airportLocationList: [AirportLocation]
    let error: APIError?

    enum CodingKeys: String, CodingKey {
        case success, error
        case airportLocationList = "response"
    }
}
