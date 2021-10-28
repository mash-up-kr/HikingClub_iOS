//
//  SignUpInputViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class SignUpInputViewController: BaseViewController<SignUpInputViewModel>, ScrollViewKeyboardApperanceProtocol {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("회원가입")
        view.setBackItemImage()
        return view
    }()
    
    var scrollView = UIScrollView()
    
    var bottomAreaView: UIView {
        nextButton
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
    
    private lazy var emailTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("이메일", description: "이메일 주소 입력", theme: .normal)
        textfield.setTheme(.normal)
        
        textfield.addSubview(emailTextFieldButton)
        emailTextFieldButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return textfield
    }()
    
    private let emailTextFieldButton = UIButton()
    
    private let passwordTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호", description: "6~18자의 비밀번호", theme: .normal)
        textfield.setTitle("비밀번호", description: "비밀번호는 6~18자로 입력해야합니다.", theme: .warning)
        textfield.setPasswordMode()
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let passwordConfirmTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호 확인", description: "비밀번호를 다시 입력해주세요.", theme: .normal)
        textfield.setTitle("비밀번호 확인", description: "비밀번호가 일치하지 않습니다.", theme: .warning)
        textfield.setPasswordMode()
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let nextButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("다음", buttonType: .ok)
        button.setEnabled(false, type: .ok)
        return button
    }()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        initKeyboardApperance()
        nextButton.setGradientColor()
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, scrollView, nextButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            
        }
        nextButton.snp.makeConstraints {
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
        textFieldStackView.addArrangedSubviews(emailTextfield, passwordTextfield, passwordConfirmTextfield)
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        emailTextFieldButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.navigateToEmailAuthorizeViewController()
            })
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text
            .skip(1)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let isValidate = self?.viewModel.isValidatePassword($0) else { return }
                self?.passwordTextfield.setTheme(isValidate ? .normal : .warning)
            })
            .disposed(by: disposeBag)
        
        passwordConfirmTextfield.rx.text
            .skip(1)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] in
                guard let isValidate = self?.viewModel.isSamePassword($0, self?.passwordTextfield.text) else { return }
                self?.passwordConfirmTextfield.setTheme(isValidate ? .normal : .warning)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tapOk
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.navigateToInitialSettingViewController()
            })
            .disposed(by: disposeBag)
        
        // MARK: - ViewModel Binding
        
        viewModel.enableNextStepRelay
            .subscribe(onNext: { [weak self] in
                self?.nextButton.setEnabled($0, type: .ok)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToEmailAuthorizeViewController() {
        // TODO: 전달받은 이메일 textField에 셋팅하기
        let viewModel = EmailAuthorizeViewModel()
        viewModel
            .authorizedEmailRelay
            .bind { print($0) }
            .disposed(by: disposeBag)
        navigationController?.pushViewController(EmailAuthorizeViewController(viewModel), animated: true)
    }
    
    private func navigateToInitialSettingViewController() {
        navigationController?.pushViewController(InitialSettingViewController(BaseViewModel()), animated: true)
    }
}
