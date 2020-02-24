//
//  UINavigationBarExtension.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 25/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import UIKit

extension UINavigationBar {

    /// Changes the navigation bar title color
    ///
    /// - Parameter color: Title color
    func setTitltColor (_ color: UIColor) {
        titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                               NSAttributedString.Key.foregroundColor: color]
    }
}
