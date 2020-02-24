//
//  LocationManagerConfigurable.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 21/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import CoreLocation

protocol LocationManagerConfigurable {
    
    func setDelegate(to instance: CLLocationManagerDelegate?)
    func setDesiredAccuracy(to accuracy: CLLocationAccuracy)
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
}
