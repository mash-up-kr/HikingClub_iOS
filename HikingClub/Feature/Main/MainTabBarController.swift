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
        UIViewController().wrappedByNavigationController()
    }()
    
    private let writeViewController: UINavigationController = {
        UIViewController().wrappedByNavigationController()
    }()
    
    private let myPageViewController: UINavigationController = {
        UIViewController().wrappedByNavigationController()
    }()
    
    private let homeTabBarItem = UITabBarItem(title: "홈", image: nil, tag: 1)
    
    private let searchTabBarItem = UITabBarItem(title: "검색", image: nil, tag: 2)
    
    private let writeTabBarItem = UITabBarItem(title: "글등록", image: nil, tag: 3)
    
    private let mypageTabBarItem = UITabBarItem(title: "마이페이지", image: nil, tag: 4)
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewController.tabBarItem = homeTabBarItem
        searchViewController.tabBarItem = searchTabBarItem
        writeViewController.tabBarItem = writeTabBarItem
        myPageViewController.tabBarItem = mypageTabBarItem
        
        setViewControllers([homeViewController, searchViewController, writeViewController, myPageViewController], animated: true)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if event?.subtype == .motionShake {
            present(ComponentTestViewController(), animated: true)
        }
    }
}
