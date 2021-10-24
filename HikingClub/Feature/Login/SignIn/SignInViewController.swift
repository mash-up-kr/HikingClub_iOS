//
//  SignInViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/16.
//

import UIKit

final class SignInViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("로그인")
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
    
    private let emailInputTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("이메일", description: "이메일 주소 입력", theme: .normal)
        return textfield
    }()
    
    private let passwordInputTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호", description: "비밀번호 입력", theme: .normal)
        return textfield
    }()
    
    private let signInButtonWrapper = UIView()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
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
        textFieldStackView.addArrangedSubviews(emailInputTextField, passwordInputTextField)
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToEmailAuthorizeViewController() {
        // TODO: 이메일 인증 화면(EmailAutorizeViewController) -> 비밀번호 변경 화면(ChangePasswordViewController)
    }
}
