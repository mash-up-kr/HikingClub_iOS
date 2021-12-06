//
//  MainOnboardingViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/12/05.
//

import UIKit
import SnapKit
import RxSwift

final class MainOnboardingViewController: UIViewController, CodeBasedProtocol {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var firstIndicator: UIView!
    @IBOutlet weak var secondIndicator: UIView!
    @IBOutlet weak var thridIndicator: UIView!
    @IBOutlet private weak var doneButton: UIButton!
    
    private var indicators: [UIView] = []
    var pageViewController: OnboardingPageViewController?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        
    }
    
    @objc
    private func tapOnboarding() {
        guard let page = pageViewController?.didChangePage.value,
              let totalPage = pageViewController?.viewList.count else {
            return
        }
        
        if page >= totalPage - 1 {
            return
        }
        
        pageViewController?.changeViewController(page+1)
    }
    
    func attribute() {
        doneButton.tintColor = .gray400
        doneButton.setFont(.medium14)
        
        indicators = [firstIndicator, secondIndicator, thridIndicator]
        indicators.forEach {
            $0.layer.cornerRadius = 8
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnboarding))
        containerView.addGestureRecognizer(tapGesture)
    }
    
    func bind() {
        doneButton.rx.tap
            .subscribe(onNext: { 
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let mainTabBarViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate,
                      let window = sceneDelegate.window else {
                          fatalError("not exist window")
                      }
                window.rootViewController = mainTabBarViewController
            })
            .disposed(by: disposeBag)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "pageViewSegue" {
            guard let vc = segue.destination as? OnboardingPageViewController else { return }
            pageViewController = vc
            
            pageViewController?.didChangePage
                .subscribe(onNext: { [weak self] in
                    self?.changeIndicatorColor(currentPage: $0)
                    self?.doneButton.isHidden = !($0 == 2)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func changeIndicatorColor(currentPage: Int) {
        for (index, element) in indicators.enumerated() {
            if index == currentPage {
                element.backgroundColor = .green500
            } else {
                element.backgroundColor = .gray200
            }
        }
    }
}
