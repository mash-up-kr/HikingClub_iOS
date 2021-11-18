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
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let isValidate = self?.viewModel.isValidatePassword($0) else { return }
                self?.passwordTextField.setTheme(isValidate ? .normal : .warning)
            })
            .disposed(by: disposeBag)
        
        passwordConfirmTextField.rx.text
            .skip(1)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let isValidate = self?.viewModel.isSamePassword($0, self?.passwordTextField.text) else { return }
                self?.passwordConfirmTextField.setTheme(isValidate ? .normal : .warning)
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tapOk
            .subscribe(onNext: { [weak self] in
                guard let password = self?.passwordConfirmTextField.text else { return }
                self?.viewModel.changePassword(password)
            })
            .disposed(by: disposeBag)
        
        // MARK: ViewModel Binding
        
        viewModel.enableNextStepRelay
            .subscribe(onNext: { [weak self] in
                self?.completeButton.setEnabled($0, type: .ok)
            })
            .disposed(by: disposeBag)
            
        viewModel.changePasswordSucceedRelay
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
