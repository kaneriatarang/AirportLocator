//
//  RequestManager.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 22/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

// MARK: - Request Manager to get nearby Airport 
class RequestManager {

    typealias GetAirportResult = Result<AirportResponse, RequestError>
    typealias GetAirportCompletion = (_ result: GetAirportResult) -> Void

    func getAirportLocations(latitude: Double, longitude:Double, completion: @escaping GetAirportCompletion) {

        let apiManager = APIManager()

        let requestURL = "https://api.aerisapi.com/places/airports/closest/?p=\(latitude),\(longitude)&limit=5&radius=30miles&filter=all&client_id=AXTH9FQA1uSeAb3xVNpSd&client_secret=jsF5X3xAIxKcrWc833XYZR65Ng2Z36dqIYfSBSpJ"

        apiManager.requestData(isWithBaseUrl: false, url: requestURL, method: .get, parameters: nil, completion: { (result) in

            DispatchQueue.main.async {

                switch result {
                case .success(let responseData) :
                    do {

                        let airportResponse = try JSONDecoder().decode(AirportResponse.self, from: responseData)
                        if airportResponse.success {
                            completion(.success(payload: airportResponse))
                        } else {
                            completion(.failure(.authorizationError(airportResponse.error)))
                        }
                    }
                    catch let parseJSONError {
                        completion(.failure(.unknownError))
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }

                case .failure(let failure) :

                    completion(.failure(failure))
                    
                }
            }
        })
    }

}

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}


