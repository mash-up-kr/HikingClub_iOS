//
//  InitialSettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class InitialSettingViewController: BaseViewController<BaseViewModel> {
    private let navigationArea: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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
        label.text = "닉네임 입력 텍스트필드 컴포넌트"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return view
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
    
    // TODO: CAT Button Component로 교쳬 예정
    private let compelteButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
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
        view.addSubviews(navigationArea, scrollView, compelteButton)
        navigationArea.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(98)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationArea.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(compelteButton.snp.top)
        }
        compelteButton.snp.makeConstraints {
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
        scrollContentsView.addSubviews(textFieldComponent, textFieldComponent2)
        textFieldComponent.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        textFieldComponent2.snp.makeConstraints {
            $0.top.equalTo(textFieldComponent.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        textFieldComponent2.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToLocationSelectViewController()
            })
            .disposed(by: disposeBag)
        
        compelteButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToCategorySettingViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToLocationSelectViewController() {
        print("동네설정 화면 푸시해주세요!")
    }
    
    private func navigateToCategorySettingViewController() {
        navigationController?.pushViewController(InitialCategorySettingViewController(), animated: true)
    }
}
