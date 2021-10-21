//
//  LoginNavigationViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/09.
//

import UIKit

final class LoginNavigationViewController: BaseViewController<LoginNavigationViewModel> {
    private let navigationButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    private let signUpButton: NDButton = {
        let button = NDButton(theme: .init(.fillGreen, textStyle: .large, radius: 8))
        button.setTitle("시작하기", for: .normal)
        return button
    }()
    
    private let emailLoginButton: NDButton = {
        let button = NDButton(theme: .init(.strokeGreen, textStyle: .large, radius: 8))
        button.setTitle("이메일 로그인", for: .normal)
        return button
    }()
    
    private let appleLoginButton: NDButton = {
        var theme = NDButtonTheme(.strokeGreen, textStyle: .large, radius: 8)
        theme.textColor = .gray900
        let button = NDButton(theme: theme)
        button.setTitle("Apple 로그인", for: .normal)
        return button
    }()
    
    private let guestLoginButton: UIButton = {
        let button = UIButton()
        button.setFont(.medium14)
        button.setTitleColor(.gray700, for: .normal)
        button.setTitle("바로 둘러보기", for: .normal)
        button.setImage(.icon_angleBracket_right_gray700_16)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubview(navigationButtonStackView)
        navigationButtonStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(38)
        }
        navigationButtonStackViewLayout()
    }
    
    private func navigationButtonStackViewLayout() {
        navigationButtonStackView.addArrangedSubviews(signUpButton,
                                                      emailLoginButton,
                                                      appleLoginButton,
                                                      guestLoginButton)
        buttonsLayout()
    }
    
    private func buttonsLayout() {
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        emailLoginButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        guestLoginButton.snp.makeConstraints {
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        signUpButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToSignUpViewController()
            })
            .disposed(by: disposeBag)
        
        emailLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToSignInViewController()
            })
            .disposed(by: disposeBag)
        
        guestLoginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSignUpViewController() {
        navigationController?.pushViewController(SignUpViewController(BaseViewModel()), animated: true)
    }
    
    private func navigateToSignInViewController() {
        navigationController?.pushViewController(SignInViewController(BaseViewModel()), animated: true)
    }
}
