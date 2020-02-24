//
//  LocationProvider.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 21/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import CoreLocation
import UIKit

class LocationProvider: NSObject, LocationProvidable, CLLocationManagerDelegate {
    var listener: LocationObservable?

    func setListener(listener: LocationObservable) {
        self.listener = listener
    }

    fileprivate var locationManager: LocationManagerConfigurable
    fileprivate var currentLocation: CLLocation?
    //fileprivate var observer: LocationObservable?

    // inject
    init(locationManager:LocationManagerConfigurable){
        self.locationManager = locationManager
    }

//    func startLocationUpdates() {
//        if (CLLocationManager.locationServicesEnabled())
//        {
//            locationManager.setDelegate(to: self)
//            locationManager.setDesiredAccuracy(to: kCLLocationAccuracyBest)
//            locationManager.requestAlwaysAuthorization()
//            locationManager.startUpdatingLocation()
//        }
//    }

    func startLocationUpdates () {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.setDelegate(to: self)
            locationManager.setDesiredAccuracy(to: kCLLocationAccuracyBest)
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                // Request when-in-use authorization initially
                // This is the first and the ONLY time you will be able to ask the user for permission
                locationManager.requestAlwaysAuthorization()
                break

            case .restricted, .denied:
                // Disable location features

                let alert = UIAlertController(title: "Allow Location Access", message: "Airport Locator needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)

                // Button to Open Settings
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                let topViewController = UIViewController.topViewController()
                topViewController?.present(alert, animated: true, completion: nil)

                break

            case .authorizedWhenInUse, .authorizedAlways:
                break
            @unknown default:
                break
            }
            locationManager.startUpdatingLocation()
        }
    }

    func getCurrentLocation() -> (Double, Double) {
        guard let currentLocation = currentLocation else {
            return (0,0)
        }
        return (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
    }

    // CLLocationManager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last,
            let listener = self.listener else {
                return
        }

        if currentLocation != nil && Double((currentLocation?.distance(from: lastLocation))!) < 100.0 {
            return
        }

        currentLocation = lastLocation
        listener.setCurrentLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
    }
}
