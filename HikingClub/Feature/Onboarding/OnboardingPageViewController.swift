//
//  OnboardingPageViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/28.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var pageArray : [UIViewController] = {
        return [self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingFirstViewController"),
                self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingSecondViewController"),
                self.VCInstane(storyboardName: "Onboarding", vcName: "OnboardingThirdViewController")]
    }()
    
    private func VCInstane(storyboardName : String, vcName : String) -> UIViewController {
        return UIStoryboard(name : storyboardName, bundle : nil).instantiateViewController(withIdentifier: vcName)
    }
}
extension OnboardingPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = pageArray.firstIndex(of: viewController) else { return nil }
        let prevIdx = vcIdx - 1

        if(prevIdx < 0){
            return nil
            
        }
        else{
            
            return pageArray[prevIdx]
        }

    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIdx = pageArray.firstIndex(of: viewController) else {return nil}
        
        let nextIdx = vcIdx + 1

        if(nextIdx >= pageArray.count){
            return nil
        }
        else{
            return pageArray[nextIdx]
        }
    }
}
