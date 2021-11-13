//
//  InitialCategorySettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class InitialCategorySettingViewController: BaseViewController<InitialCategorySettingViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("카테고리 설정")
        view.setRightItemImage(.icon_crossX_gray900_24, tintColor: .gray900)
        return view
    }()
    
    private let categoryCollectionView: CategoryCollectionView = {
        let view = CategoryCollectionView()
        return view
    }()
    
    private let bottomCTAButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .two)
        button.setTitle("선택완료", buttonType: .ok)
        button.setTitle("나중에", buttonType: .cancel)
        return button
    }()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        setupCategoryCollectionView()
    }
    
    private func setupCategoryCollectionView() {
        viewModel.categoryWords
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionView.cellIdentifier, cellType: CategoryCollectionViewCell.self)) { indexPath, cellModel, cell in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, categoryCollectionView, bottomCTAButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            
            $0.height.equalTo(304)
        }
        bottomCTAButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        // TODO: twoButton CTA 버튼이므로, 컴포넌트 적용 후 액션 나눌것
        bottomCTAButton.rx.tapOk
            .subscribe(onNext: { [weak self] in
                self?.navigateToHomeViewController()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToHomeViewController() {
        // TODO: dismiss and viewModel navigation dismiss logic 구현하기
        dismiss(animated: true, completion: nil)
    }
}
