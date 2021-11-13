//
//  PersonalInformationViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/13.
//

import UIKit

class PersonalInformationViewController: BaseViewController<PersonalInformationViewModel>, ScrollViewKeyboardApperanceProtocol{
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("개인정보 설정")
        view.setBackItemImage()
        return view
    }()
    
    var scrollView = UIScrollView()
    
    var bottomAreaView: UIView {
        nextButton // 버튼 attribute
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
    
    private let passwordTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("비밀번호", description: "6~18자의 비밀번호", theme: .normal)
        textfield.setTitle("비밀번호", description: "비밀번호는 6~18자로 입력해야합니다.", theme: .warning)
        textfield.setPasswordMode()
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private let nextButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("확인", buttonType: .ok)
        button.setEnabled(false, type: .ok)
        return button
    }()
    
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
        textFieldStackView.addArrangedSubviews(passwordTextfield)
    }
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
//        passwordTextfield.rx.text
//            .skip(1)
//            .filter { !$0.isEmpty }
//            .subscribe(onNext: { [weak self] in
//                guard let isValidate = self?.viewModel.isValidatePassword($0) else { return }
//                self?.passwordTextfield.setTheme(isValidate ? .normal : .warning)
//            })
//            .disposed(by: disposeBag)
    }
//    private func navigateToInitialSettingViewController() {
//        navigationController?.pushViewController(InitialSettingViewController(BaseViewModel()), animated: true)
//    }
}
