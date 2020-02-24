//
//  ErrorRespoance.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

// ErrorResponse of API
class ErrorResponse: Codable {

    let success: Bool
    let errors: APIError?
}

class APIError: Codable {
    let code: String
    let description: String
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(APIError?)
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}

// Error to display in View
enum HomeError {
    case internetError(String)
    case serverMessage(String)
}
