//
//  SignUpViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/09.
//

import UIKit

final class SignUpViewController: BaseViewController<BaseViewModel> {
    private let navigationArea: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    private let greetingView = GreetingView()
    private let termStackView = SignUpTermsStackView()
    private let termNoticeLabel: UILabel = {
        let label = UILabel()
        label.setFont(.medium12)
        label.numberOfLines = .zero
        label.textColor = .lightGray
        label.lineBreakMode = .byCharWrapping
        label.text = "개인정보 처리 방침에 동의하지 않으셔도 비회원으로 서비스 이용이 가능합니다. 비회원으로 서비스 이용시 일부 기능에 제한이 있을 수 있습니다."
        return label
    }()
    // TODO: CAT Button Component로 교쳬 예정
    private let agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("동의하기", for: .normal)
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
        view.addSubViews(navigationArea, greetingView, termStackView, termNoticeLabel, agreeButton)
        navigationArea.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(98)
        }
        greetingView.snp.makeConstraints {
            $0.top.equalTo(navigationArea.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview()
        }
        termStackView.snp.makeConstraints {
            $0.top.equalTo(greetingView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
        termNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(termStackView.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        agreeButton.snp.makeConstraints {
            $0.bottom.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(122)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        termStackView.didTapDetailButton
            .subscribe(onNext: { [weak self] in
                self?.navigateToTermDetailViewController($0)
            })
            .disposed(by: disposeBag)
        
        agreeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToSignUpInputViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSignUpInputViewController() {
        navigationController?.pushViewController(SignUpInputViewController(BaseViewModel()), animated: true)
    }
    
    private func navigateToTermDetailViewController(_ termType: SignUpTermsStackView.SignUpTermType) {
        let viewController = TermDetailViewController(BaseViewModel())
        viewController.termType = termType
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
