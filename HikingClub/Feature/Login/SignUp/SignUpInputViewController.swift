//
//  SignUpInputViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class SignUpInputViewController: BaseViewController<BaseViewModel>, ScrollViewKeyboardApperanceProtocol {
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
        
        return textfield
    }()
    
    private let passwordConfirmTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호 확인", description: "비밀번호를 다시 입력해주세요.", theme: .normal)
        
        return textfield
    }()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        initKeyboardApperance()
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
                self?.navigateToEmailAuthorizeViewController()
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToInitialSettingViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToEmailAuthorizeViewController() {
        navigationController?.pushViewController(EmailAuthorizeViewController(BaseViewModel()), animated: true)
    }
    
    private func navigateToInitialSettingViewController() {
        navigationController?.pushViewController(InitialSettingViewController(BaseViewModel()), animated: true)
    }
}
