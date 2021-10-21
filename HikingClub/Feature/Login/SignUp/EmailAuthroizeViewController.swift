//
//  EmailAuthroizeViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class EmailAuthorizeViewController: BaseViewController<BaseViewModel>, ScrollViewKeyboardApperanceProtocol {
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
        textfield.setTitle("이메일")
        textfield.setPlaceholder("이메일 주소 입력")
        
        return textfield
    }()
    
    private let authenticationEmailReceiveButton: NDButton = {
        let button = NDButton(theme: .init(.strokeGreen))
        button.setTitle("인증 메일 받기", for: .normal)
        
        return button
    }()
    
    private let authenticationNumberTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("인증번호", description: "입력한 이메일에서 인증번호를 확인해주세요.")
        
        return textfield
    }()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let authorizeButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증하기", for: .normal)
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
        
        authorizeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
