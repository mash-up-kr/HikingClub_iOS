//
//  ChangePasswordViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/16.
//

import UIKit

final class ChangePasswordViewController: BaseViewController<ChangePasswordViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("비밀번호 변경")
        view.setBackItemImage()
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollContentsView = UIView()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 48
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    private let passwordTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("새로운 비밀번호", description: "6~18자의 비밀번호", theme: .normal)
        textfield.setTitle("새로운 비밀번호", description: "비밀번호는 6~18자로 입력해야합니다.", theme: .warning)
        textfield.setPasswordMode()
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let passwordConfirmTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호 확인", description: "비밀번호를 다시 입력해주세요.", theme: .normal)
        textfield.setTitle("비밀번호 확인", description: "비밀번호가 일치하지 않습니다.", theme: .warning)
        textfield.setPasswordMode()
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let completeButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("완료", buttonType: .ok)
        button.setEnabled(false, type: .ok)
        return button
    }()
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, scrollView, completeButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        completeButton.snp.makeConstraints {
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
        textFieldStackView.addArrangedSubviews(passwordTextField, passwordConfirmTextField)
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.validatePassword($0)
            })
            .disposed(by: disposeBag)
        
        passwordConfirmTextField.rx.text
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.confirmPassword($0, self?.passwordTextField.text)
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tapOk
            .withLatestFrom(passwordConfirmTextField.rx.text)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.changePassword($0)
            })
            .disposed(by: disposeBag)
        
        // MARK: ViewModel Binding
        
        viewModel.passwordValidateRelay
            .skip(1)
            .subscribe(onNext: { [weak self] isValidate in
                self?.passwordTextField.setTheme(isValidate ? .normal : .warning)
                if isValidate {
                    self?.checkWithPasswordConfirm()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.passwordConfirmRelay
            .skip(1)
            .subscribe(onNext: { [weak self] isValidate in
                self?.passwordConfirmTextField.setTheme(isValidate ? .normal : .warning)
            })
            .disposed(by: disposeBag)
        
        viewModel.enableNextStepRelay
            .bind { [weak self] in self?.completeButton.rx.isEnabled.onNext($0) }
            .disposed(by: disposeBag)
            
        viewModel.changePasswordSucceedRelay
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func checkWithPasswordConfirm() {
        guard let checkPassword = passwordConfirmTextField.text, false == checkPassword.isEmpty else {
            return 
        }
        let standardPassword = passwordTextField.text
        viewModel.confirmPassword(checkPassword, standardPassword)
    }
}
