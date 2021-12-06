//
//  OnboardingPageViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/28.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingPageViewController: UIPageViewController {
    let didChangePage = BehaviorRelay<Int>(value: 0)
    
    let viewList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingFirstViewController")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingSecondViewController")
        let thirdViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingThirdViewController")
        
        return[firstViewController, secondViewController, thirdViewController]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        changeViewController(0)
    }
    
    func changeViewController(_ index: Int) {
        let vc = viewList[index]
        didChangePage.accept(index)
        self.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardingPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewList.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = index - 1
        
        if(previousIndex < 0){
            return nil
        } else{
            return viewList[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = index + 1
        
        if(nextIndex >= viewList.count){
            return nil
        } else{
            return viewList[nextIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if pageViewController.viewControllers?.first as? OnboardingFirstViewController != nil {
            didChangePage.accept(0)
        } else if pageViewController.viewControllers?.first as? OnboardingSecondViewController != nil {
            didChangePage.accept(1)
        } else if pageViewController.viewControllers?.first as? OnboardingThirdViewController != nil {
            didChangePage.accept(2)
        }
    }
}
