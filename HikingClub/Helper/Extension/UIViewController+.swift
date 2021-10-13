//
//  UIViewController+.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/13.
//

import UIKit

extension UIViewController {
    func wrappedByNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}
