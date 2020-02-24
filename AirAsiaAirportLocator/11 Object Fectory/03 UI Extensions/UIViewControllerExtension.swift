//
//  UIViewControllerExtension.swift
//  AirAsiaAirportLocator
//
//  Created by Tarang Kaneriya on 24/02/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import UIKit

extension UIViewController {

    static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {

        let viewController = viewController ?? UIWindow.key?.rootViewController

        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        {
            return self.topViewController(navigationController.viewControllers.last)

        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return self.topViewController(selectedController)

        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)

        }

        return viewController
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

