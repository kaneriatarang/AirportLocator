//
//  DoubleExtension.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 22/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import Foundation
import MapKit

extension Double {
    func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
        return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
    }
}

extension CLLocationDistance {

    func metersToMiles() -> CLLocationDistance {
        return self.convert(from: .meters, to: .miles)
    }

    func inKilometers() -> CLLocationDistance {
        return self/1000
    }

    func milesToMeters() -> CLLocationDistance {
        return self.convert(from: .miles, to: .meters)
    }

}
