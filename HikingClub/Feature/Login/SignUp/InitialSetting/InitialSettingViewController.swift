//
//  InitialSettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class InitialSettingViewController: BaseViewController<BaseViewModel>, ScrollViewKeyboardApperanceProtocol {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("기본설정")
        view.setBackItemImage()
        return view
    }()
    
    var scrollView = UIScrollView()
    
    var bottomAreaView: UIView {
        completeButton
    }
    
    private let scrollContentsView = UIView()
    
    private let nickNameTextField: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("닉네임", description: "닉네임은 공백 포함 2-10자로 작성해 주세요.", theme: .normal)
        return textfield
    }()
    
    private let townTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.rx.theme.onNext(.selected)
        textfield.setTitle("동네선택", description: "관심있는 동네를 선택해 주세요.", theme: .normal)
        return textfield
    }()
    
    private let textFieldComponent2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.snp.makeConstraints {
            $0.height.equalTo(77)
        }
        button.setTitle("동네 선택 텍스트필드 컴포넌트", for: .normal)
        
        return button
    }()
    
    private let completeButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("완료", buttonType: .ok)
        return button
    }()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        completeButton.setGradientColor()
    }
    
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
            $0.bottom.equalTo(completeButton.snp.top)
        }
        completeButton.snp.makeConstraints {
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
        scrollContentsView.addSubViews(nickNameTextField, townTextfield)
        nickNameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        townTextfield.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(48)
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

        townTextfield.rx.tapDetailButton
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToLocationSelectViewController()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tapOk
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToCategorySettingViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToLocationSelectViewController() {
        print("동네설정 화면 푸시해주세요!")
    }
    
    private func navigateToCategorySettingViewController() {
        let viewController = InitialCategorySettingViewController(BaseViewModel())
        viewController.modalPresentationStyle = .fullScreen
        // TODO: ViewModel에 dismiss relay 구독하기
        present(viewController, animated: true)
    }
}
