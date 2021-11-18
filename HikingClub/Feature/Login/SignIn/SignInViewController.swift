//
//  SignInViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/16.
//

import UIKit

final class SignInViewController: BaseViewController<SignInViewModel>, ScrollViewKeyboardApperanceProtocol {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("로그인")
        view.setBackItemImage()
        return view
    }()
    
    var scrollView = UIScrollView()
    
    var bottomAreaView: UIView {
        signInButton
    }
    
    private let scrollContentsView = UIView()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 48
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    private let emailInputTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("이메일", description: nil, theme: .normal)
        textfield.setPlaceholder("이메일 주소 입력")
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let passwordWrapper = UIView()
    
    private let passwordInputTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호", description: nil, theme: .normal)
        textfield.setPlaceholder("비밀번호 입력")
        textfield.setTheme(.normal)
        textfield.setPasswordMode()
        return textfield
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setFont(.medium14)
        button.setTitle("비밀번호 찾기", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(.icon_angleBracket_right_gray700_16)
        button.setTitleColor(.gray700, for: .normal)
        
        return button
    }()
    
    private let signInButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("로그인", buttonType: .ok)
        return button
    }()
    
    // MARK: - Attribute

    override func attribute() {
        super.attribute()
        initKeyboardApperance()
        signInButton.setGradientColor()
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, scrollView, signInButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
        scrollView.addSubview(scrollContentsView)
        scrollContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
            $0.width.equalTo(view)
        }
        
        scrollContentsViewLayout()
    }
    
    private func scrollContentsViewLayout() {
        scrollContentsView.addSubview(textFieldStackView)
        textFieldStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        textFieldStackViewLayout()
    }
    
    private func textFieldStackViewLayout() {
        textFieldStackView.addArrangedSubviews(emailInputTextField, passwordWrapper)
        passwordWrapperLayout()
    }
    
    private func passwordWrapperLayout() {
        passwordWrapper.addSubViews(passwordInputTextField, forgotPasswordButton)
        passwordInputTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordInputTextField.snp.bottom).offset(12)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tapOk
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                guard let email = self?.emailInputTextField.text,
                      let password = self?.passwordInputTextField.text else { return }
                self?.viewModel.requestLogin(email, password)
            })
            .disposed(by: disposeBag)
        
        forgotPasswordButton.rx.tap
            .subscribe(onNext: { [weak self] in
                 self?.navigateToEmailAuthorizeViewController()
            })
            .disposed(by: disposeBag)
        
        // MARK: - ViewModel Binding
        viewModel.loginSucceededRelay
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToEmailAuthorizeViewController() {
        let viewModel = EmailAuthorizeViewModel(.forgotPassword)
        viewModel.authorizedEmailRelay
            .subscribe(onNext: { [weak self] in
                self?.navigateToChangePasswordViewController($0)
            })
            .disposed(by: disposeBag)
        let viewController = EmailAuthorizeViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToChangePasswordViewController(_ authroizedEmail: String) {
        let viewModel = ChangePasswordViewModel(authroizedEmail)
        let viewController = ChangePasswordViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
