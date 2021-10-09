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
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setFont(.semiBold16)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("시작하기", for: .normal)
        
        return button
    }()
    
    private let emailLoginButton: UIButton = {
        let button = UIButton()
        button.setFont(.semiBold16)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("이메일 로그인", for: .normal)
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setFont(.semiBold16)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Apple 로그인", for: .normal)
        return button
    }()
    
    private let guestLoginButton: UIButton = {
        let button = UIButton()
        button.setFont(.semiBold16)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("바로 둘러보기 >", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
    }
    
    // MARK: - Attribute
    
    private func attribute() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubview(navigationButtonStackView)
        navigationButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
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
    
    // TODO: 버튼 컴포넌트가 완료되면 되면 height이 결정되기 때문에 컴포넌트 적용 후 삭제
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
    
    private func bind() {
        guestLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// TODO: Move To Extension
extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
