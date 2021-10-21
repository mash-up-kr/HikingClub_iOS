//
//  ChangePasswordViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/16.
//

import UIKit

final class ChangePasswordViewController: BaseViewController<BaseViewModel> {
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
    
    private let passwordInputTextField: NDTextFieldView = {
        let view = NDTextFieldView(scale: .big)
        view.setTitle("새로운 비밀번호")
        view.setPlaceholder("6-18자의 비밀번호")
        return view
    }()
    
    private let passwordConfirmInputTextField: NDTextFieldView = {
        let view = NDTextFieldView(scale: .big)
        view.setTitle("비밀번호 확인")
        view.setPlaceholder("비밀번호를 다시 입력해주세요.")
        return view
    }()
    
    private let signInButtonWrapper = UIView()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .gray
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
        textFieldStackView.addArrangedSubviews(passwordInputTextField, passwordConfirmInputTextField)
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToSignInViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSignInViewController() {
        // TODO: 이메일 인증 화면 후 로그인 화면으로 돌아가야 하므로 필요한 로직
        guard let navigationController = navigationController,
              let signInViewController = navigationController.viewControllers.filter({ $0 is SignInViewController }).first
        else { return }
        
        navigationController.popToViewController(signInViewController, animated: true)
    }
}
