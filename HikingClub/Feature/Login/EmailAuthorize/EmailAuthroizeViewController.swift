//
//  EmailAuthroizeViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class EmailAuthorizeViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("이메일 인증")
        view.setBackItemImage()
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollContentsView = UIView()

    private let textFieldComponent: UIView = {
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
    
    private let sendAuthEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증 메일 받기", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    private let textFieldComponent2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.snp.makeConstraints {
            $0.height.equalTo(77)
        }
        
        let label = UILabel()
        label.text = "텍스트필드 컴포넌트 + 설명"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return view
    }()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let authorizeButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증하기", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
        
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
        scrollContentsView.addSubViews(textFieldComponent, sendAuthEmailButton, textFieldComponent2)
        textFieldComponent.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        sendAuthEmailButton.snp.makeConstraints {
            $0.top.equalTo(textFieldComponent.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        textFieldComponent2.snp.makeConstraints {
            $0.top.equalTo(sendAuthEmailButton.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
