//
//  MapViewModel.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 21/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation

typealias CompletionBlock = (_ success: Bool, _ object: AnyObject?) -> ()

// MARK: - MapViewModel Protocols

protocol MapViewModelConfirming {
    func getCurrentLocation() -> (Double, Double)
    func centerMapToCurrentLocationAction()
}

protocol MapViewModelObservable {
    // This needs to be supplied by the VM Observer
    associatedtype Location

    func setCurrentLocation(latitude: Double, longitude: Double)
    func addLocationToMap(location: Location)
    func centerMapToCurrentLocation(latitude: Double, longitude: Double)
}


// MARK: - MapViewModel

// MapviewModel: Protocol implementation
class MapViewModel<S:MapViewModelObservable>: MapViewModelConfirming, LocationObservable {

    var locationProvider: LocationProvidable
    var requestManager: RequestManager
    var listenerView: S

    var airportLocationList = [AirportLocation]()
    var didUpdate: ((MapViewModel) -> Void)?
    var onError : ((HomeError)->Void)?


    // Inject the dependencies in controller
    init(locationProvider: LocationProvidable, requestManager: RequestManager, listener: S) {
        self.locationProvider = locationProvider
        self.locationProvider.startLocationUpdates()
        self.requestManager = requestManager
        self.listenerView = listener

        defer {
            self.locationProvider.setListener(listener: self)
        }
    }

    //Fetch Current Location using Location Manager
    func getCurrentLocation() -> (Double, Double) {
        let (lat, lon) = locationProvider.getCurrentLocation()
        return (lat, lon)
    }

    //Fetch nearby Airport Locations using current location through API
    func getAirports() {

        let (lat, lon) = getCurrentLocation()
        print("latitude: \(lat) longitude: \(lon)")

        if lat == 0 && lon == 0 {
            return
        }

        requestManager.getAirportLocations(latitude: lat, longitude: lon) { [weak self] result in

            guard let strongSelf = self else { return }

            switch result {
            case .success(let airportResponse) :

                strongSelf.airportLocationList = airportResponse.airportLocationList
                strongSelf.didUpdate?(strongSelf)

            case .failure(let failure) :

                switch failure {

                case .connectionError:
                    strongSelf.onError?(.internetError("Check your Internet connection."))

                case .authorizationError(let errorResponse):
                    strongSelf.onError?(.serverMessage(errorResponse?.description ?? ""))

                default:
                    strongSelf.onError?(.serverMessage("Unknown Error"))

                }
            }
        }
    }

    // Message from the location provider
    func setCurrentLocation(latitude: Double, longitude: Double) {
        listenerView.setCurrentLocation(latitude: latitude, longitude: longitude)
    }

    func centerMapToCurrentLocationAction() {
        let currentLocation = getCurrentLocation()
        listenerView.centerMapToCurrentLocation(latitude: currentLocation.0, longitude: currentLocation.1)
    }
}
