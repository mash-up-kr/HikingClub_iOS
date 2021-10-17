//
//  SignUpInputViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class SignUpInputViewController: BaseViewController<BaseViewModel> {
    private let navigationArea: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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
        button.setTitle("텍스트필드 컴포넌트", for: .normal)
        
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
    
    private let textFieldComponent3: UIView = {
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
    
    // TODO: CAT Button Component로 교쳬 예정
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationArea, scrollView, nextButton)
        navigationArea.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(98)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationArea.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        nextButton.snp.makeConstraints {
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
        textFieldStackView.addArrangedSubviews(textFieldComponent, textFieldComponent2, textFieldComponent3)
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        textFieldComponent.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToEmailAuthorizeViewController()
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
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
