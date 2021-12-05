//
//  LottieOnboardingViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/28.
//

import UIKit
import RxCocoa
import RxSwift

final class LottieOnboardingViewController: UIViewController, CodeBasedProtocol {
    
    @IBOutlet private weak var onboardingStartButtonView: NDButton!
    private var disposeBag = DisposeBag()
    
    func onboardingStartButton() {
        onboardingStartButtonView.setTitle("나들길 들어가기", for: .normal)
        onboardingStartButtonView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        bind()
    }
    
    func attribute() {
        onboardingStartButton()
    }
    
    func bind() {
        onboardingStartButtonView.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let onboardingPageViewController = self?.storyboard?.instantiateViewController(withIdentifier: "MainOnboardingViewController") else {
                    return
                }
                self?.navigationController?.pushViewController(onboardingPageViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
