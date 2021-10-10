//
//  SignUpViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/09.
//

import UIKit

class SignUpViewController: BaseViewController<BaseViewModel> {
    private let greetingView: GreetingView = GreetingView()
    private let termStackView: SignUpTermsStackView = SignUpTermsStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    // MARK: - Attribute
    
    private func attribute() {
    }
    
    // MARK: - Layout
    private func layout() {
        view.addSubviews(greetingView, termStackView)
        greetingView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        
        termStackView.snp.makeConstraints {
            $0.top.equalTo(greetingView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
