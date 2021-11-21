//
//  EmailAuthroizeViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit
import RxSwift

final class EmailAuthorizeViewController: BaseViewController<EmailAuthorizeViewModel>, ScrollViewKeyboardApperanceProtocol {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("이메일 인증")
        view.setBackItemImage()
        return view
    }()
    
    var scrollView = UIScrollView()
    
    var bottomAreaView: UIView {
        authorizeButton
    }
    
    private let scrollContentsView = UIView()
    
    private let emailTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("이메일", description: nil, theme: .normal)
        textfield.setPlaceholder("이메일 주소 입력")
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let authenticationEmailReceiveButton: NDButton = {
        let button = NDButton(theme: .init(.strokeGreen))
        button.setTitle("인증 메일 받기", for: .normal)
        return button
    }()
    
    private let authenticationNumberTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("인증번호", description: "입력한 이메일에서 인증번호를 확인해주세요.", theme: .normal)
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let authorizeButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("인증하기", buttonType: .ok)
        button.setEnabled(false, type: .ok)
        return button
    }()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        initKeyboardApperance()
        authorizeButton.setGradientColor()
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, scrollView, authorizeButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(authorizeButton.snp.top)
        }
        authorizeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
            
            $0.height.equalTo(122)
        }
        scrollView.addSubview(scrollContentsView)
        scrollContentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
            $0.width.equalTo(view)
        }
        
        scrollContentsViewLayout()
    }
    
    private func scrollContentsViewLayout() {
        scrollContentsView.addSubViews(emailTextfield, authenticationEmailReceiveButton, authenticationNumberTextfield)
        emailTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        authenticationEmailReceiveButton.snp.makeConstraints {
            $0.top.equalTo(emailTextfield.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
            $0.height.equalTo(44)
        }
        authenticationNumberTextfield.snp.makeConstraints {
            $0.top.equalTo(authenticationEmailReceiveButton.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
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
        
        authenticationEmailReceiveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
                guard let email = self?.emailTextfield.text, !email.isEmpty else { return }
                self?.viewModel.requestEmailAuthCode(email)
            })
            .disposed(by: disposeBag)
        
        authenticationNumberTextfield.rx.text
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] _ in
                self?.authorizeButton.setEnabled(true, type: .ok)
            })
            .disposed(by: disposeBag)
            
        authorizeButton.rx.tapOk
            .subscribe(onNext: { [weak self] in
                guard
                    let self = self,
                    let email = self.emailTextfield.text,
                    let code = self.authenticationNumberTextfield.text
                else { return }
                if !email.isEmpty && !code.isEmpty {
                    self.viewModel.isRightAuthCode(email, code)
                }
            })
            .disposed(by: disposeBag)
        
        // MARK: ViewModel Binding
        viewModel.authorizeSucceedRelay
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                self?.viewModel.authorizedEmailRelay.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
