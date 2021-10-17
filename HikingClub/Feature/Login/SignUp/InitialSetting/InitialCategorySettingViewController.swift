//
//  InitialCategorySettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class InitialCategorySettingViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("카테고리 설정")
        // TODO: 오른쪽 닫기 icon 적용하기
        return view
    }()
    
    private let categoryCollectionViewArea: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let twoButtonComponentButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증하기", for: .normal)
        button.backgroundColor = .gray
        return button
    }()

    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, categoryCollectionViewArea ,twoButtonComponentButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        categoryCollectionViewArea.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
            $0.height.equalTo(348)
        }
        twoButtonComponentButton.snp.makeConstraints {
            $0.bottom.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(122)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        // TODO: twoButton CTA 버튼이므로, 컴포넌트 적용 후 액션 나눌것
        twoButtonComponentButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToHomeViewController()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToHomeViewController() {
        // TODO: dismiss and viewModel navigation dismiss logic 구현하기
        dismiss(animated: true, completion: nil)
    }
}
