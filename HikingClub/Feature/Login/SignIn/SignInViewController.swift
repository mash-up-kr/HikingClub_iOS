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
    
    private let textFieldComponent: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.snp.makeConstraints {
            $0.height.equalTo(77)
        }
        
        button.setTitle("비밀번호 찾기(아이디입력textField영역임)", for: .normal)
        return button
    }()
    
    private let textFieldComponent2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.snp.makeConstraints {
            $0.height.equalTo(77)
        }
        
        let label = UILabel()
        label.text = "텍스트필드 컴포넌트"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return view
    }()
    
    private let signInButtonWrapper = UIView()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    // MARK: - Layout
    
    private func layout() {
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
        textFieldStackView.addArrangedSubviews(textFieldComponent, textFieldComponent2)
    }
    
    // MARK: - Bind
    
    private func bind() {
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        textFieldComponent.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToForgotPasswordViewController()
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToForgotPasswordViewController() {
        navigationController?.pushViewController(ForgotPasswordViewController(BaseViewModel()), animated: true)
    }
}
