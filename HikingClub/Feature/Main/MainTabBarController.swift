//
//  MainTabBarController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/09/20.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private let homeViewController: UINavigationController = {
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryBoard.instantiateViewController(identifier: "HomeViewController") { coder -> HomeViewController in
            return .init(coder, HomeViewModel())!
        }
        return homeViewController.wrappedByNavigationController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([homeViewController], animated: true)
    }
}
