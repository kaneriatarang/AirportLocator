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

extension UINavigationBar {

    /// Changes the navigation bar title color
    ///
    /// - Parameter color: Title color
    func setTitltColor (_ color: UIColor) {
        titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                               NSAttributedString.Key.foregroundColor: color]
    }
}
