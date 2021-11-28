//
//  LottieOnboardingViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/28.
//

import UIKit
import Lottie

class LottieOnboardingViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("tap")
        let storyboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OnboardingFirstViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
