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
        let homeViewController = homeStoryBoard.instantiate("HomeViewController") { coder -> HomeViewController in
                .init(coder, HomeViewModel()) ?? HomeViewController(HomeViewModel())
        }
        return homeViewController.wrappedByNavigationController()
    }()
    
    private let searchViewController: UINavigationController = {
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let searchViewController = searchStoryboard.instantiate("SearchViewController") { coder -> SearchViewController? in
                .init(coder, SearchViewModel())
        }
        return searchViewController.wrappedByNavigationController()
    }()
    
    private let writeViewController: UINavigationController = {
        UIViewController().wrappedByNavigationController()
    }()
    
    private let myPageViewController: UINavigationController = {
        MyPageViewController(BaseViewModel()).wrappedByNavigationController()
    }()
    
    private let homeTabBarItem = UITabBarItem(normalAsset: .icon_tabbar_house_deselected_gray200_28,
                                              selectedAsset: .icon_tabbar_house_selected_green900_28)
    
    private let searchTabBarItem = UITabBarItem(normalAsset: .icon_tabbar_magnifier_left_deselected_gray200_28,
                                                selectedAsset: .icon_tabbar_magnifier_left_selected_green900_28)
    
    private let writeTabBarItem = UITabBarItem(normalAsset: .icon_tabbar_pencil_deselected_gray200_28,
                                               selectedAsset: .icon_tabbar_pencil_selected_green900_28)
    
    private let mypageTabBarItem = UITabBarItem(normalAsset: .icon_tabbar_person_deselected_gray200_28,
                                                selectedAsset: .icon_tabbar_person_selected_green900_28)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        homeViewController.tabBarItem = homeTabBarItem
        searchViewController.tabBarItem = searchTabBarItem
        writeViewController.tabBarItem = writeTabBarItem
        myPageViewController.tabBarItem = mypageTabBarItem
        
        setViewControllers([homeViewController, searchViewController, writeViewController, myPageViewController], animated: false)
    }
    
#if DEBUG
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if event?.subtype == .motionShake {
            let testVC = ComponentTestViewController()
            present(testVC, animated: true)
        }
    }
#endif
}
