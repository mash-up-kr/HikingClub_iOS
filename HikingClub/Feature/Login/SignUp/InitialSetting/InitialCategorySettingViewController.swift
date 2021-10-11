//
//  InitialCategorySettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class InitialCategorySettingViewController: BaseViewController<BaseViewModel> {
    private let navigationArea: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        bind()
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubviews(navigationArea, categoryCollectionViewArea ,twoButtonComponentButton)
        navigationArea.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(98)
        }
        categoryCollectionViewArea.snp.makeConstraints {
            $0.top.equalTo(navigationArea.snp.bottom).offset(48)
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
    
    private func bind() {
        // TODO: twoButton CTA 버튼이므로, 컴포넌트 적용 후 액션 나눌것
        twoButtonComponentButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToHomeViewController()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToHomeViewController() {
        guard let loginViewController = navigationController?.viewControllers.first as? LoginNavigationViewController else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            loginViewController.dismiss(animated: true, completion: nil)
        }
    }
}
