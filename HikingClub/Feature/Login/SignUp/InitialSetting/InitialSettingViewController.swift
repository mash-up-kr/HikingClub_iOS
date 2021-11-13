//
//  InitialSettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit
import RxSwift
import RxRelay

final class InitialSettingViewController: BaseViewController<InitialSettingViewModel>, ScrollViewKeyboardApperanceProtocol {
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
        textfield.setTitle("닉네임", description: "닉네임을 올바르게 입력해 주세요.", theme: .warning)
        textfield.setTheme(.normal)
        return textfield
    }()
    
    private lazy var townTextfield: NDTextFieldView = {
        let textfield = NDTextFieldView(scale: .big)
        textfield.setTitle("동네선택", description: "관심있는 동네를 선택해 주세요.", theme: .selected)
        textfield.setTheme(.selected)
        
        textfield.addSubview(townTextFieldButton)
        townTextFieldButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return textfield
    }()
    
    private let townTextFieldButton = UIButton()
    
    private let completeButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("완료", buttonType: .ok)
        button.setEnabled(false, type: .ok)
        return button
    }()
    
    // TODO: MOVE TO ViewModel
    private var isVaildateNickname: Bool = false
    
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

        townTextFieldButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
                self?.navigateToLocationSelectViewController()
            })
            .disposed(by: disposeBag)
        
        nickNameTextField.rx.text
            .skip(1)
            .subscribe(onNext: { [weak self] in
                if false == self?.isValidteNickname($0) ?? false {
                    self?.nickNameTextField.setTheme(.warning)
                    self?.isVaildateNickname = false
                } else {
                    self?.nickNameTextField.setTheme(.normal)
                    self?.isVaildateNickname = true
                }
                self?.updateCompleteButton()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tapOk
            .subscribe(onNext: { [weak self] _ in
                guard let nickname = self?.nickNameTextField.text,
                      let place = self?.viewModel.townRelay.value
                else { return }
                self?.viewModel.signUp(nickname, place.code)
            })
            .disposed(by: disposeBag)
        
        // MARK: ViewModel Binding
        viewModel.signUpSucceedRelay
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToHomeViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToLocationSelectViewController() {
        let viewModel = SelectTownViewModel()
        viewModel.selectedTownRelay
            .subscribe(onNext: { [weak self] in
                self?.viewModel.townRelay.accept($0)
                self?.setTown()
            })
            .disposed(by: disposeBag)
        navigationController?.pushViewController(SelectTownViewController(viewModel), animated: true)
    }
    
    private func navigateToCategorySettingViewController() {
        // TODO: 초기 카테고리 설정 화면 연결하기
        let viewController = InitialCategorySettingViewController(InitialCategorySettingViewModel())
        viewController.modalPresentationStyle = .fullScreen
        // TODO: ViewModel에 dismiss relay 구독하기
        present(viewController, animated: true)
    }
    
    private func navigateToHomeViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func setTown() {
        guard let place = viewModel.townRelay.value else { return }
        townTextfield.text = place.fullAddress
        updateCompleteButton()
    }
    
    private func isValidteNickname(_ nickname: String) -> Bool {
        if nickname.count < 2 || nickname.count > 11 {
            return false
        } else {
            return true
        }
    }
    
    private func updateCompleteButton() {
        guard let town = townTextfield.text else {
            completeButton.setEnabled(false, type: .ok)
            return
        }
        if isVaildateNickname && !town.isEmpty {
            completeButton.setEnabled(true, type: .ok)
        } else {
            completeButton.setEnabled(false, type: .ok)
        }
    }
}
