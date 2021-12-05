//
//  SettingViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/03.
//

import UIKit

final class SettingViewController: BaseViewController<SettingViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("설정")
        view.setBackItemImage()
        
        return view
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollContentsView = UIView()
    
    private let menuStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let townMenu = MenuButtonView(.town)
    
    private let personalInformationMenu = MenuButtonView(.personlInformation)
    
    private let versionMenu = MenuButtonView(.version)
    
    private let noticeMenu = MenuButtonView(.notice)
    
    private let inquiryMenu = MenuButtonView(.inquiry)
    
    private let signOutMenu = MenuButtonView(.signOut)
    
    private let withdrawMenu = MenuButtonView(.withdraw)
    
    private let opensourceMenu = MenuButtonView(.opensource)
    
    private lazy var signOutAlert: NDAlert = {
        let alert = NDAlert(buttonStyle: .two,
                            title: "로그아웃 하시겠습니까?",
                            description: "나들길은 당신을 기다리고 있을게요.",
                            okTitle: "로그아웃",
                            okHandler: { [weak self] in self?.viewModel.signOut() },
                            cancelTitle: "취소",
                            cancelHandler: nil)
        return alert
    }()
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, scrollView)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
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
        scrollContentsView.addSubview(menuStackView)
        menuStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        menuStackViewLayout()
    }
    
    private func menuStackViewLayout() {
        menuStackView.addArrangedSubviews(townMenu,
                                          personalInformationMenu,
                                          versionMenu,
                                          inquiryMenu,
                                          signOutMenu,
                                          withdrawMenu,
                                          opensourceMenu)
    }
    
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        versionMenu.rx.tap
            .subscribe(onNext: { [weak self] in
                let versionInfoStoryboard = UIStoryboard(name: "VersionInfo", bundle: nil)
                let versionInfoViewContoller = versionInfoStoryboard.instantiate("VersionInfoViewController") { coder -> VersionInfoViewController in
                        .init(coder,BaseViewModel()) ?? VersionInfoViewController(BaseViewModel())
                }
                self?.navigationController?.pushViewController(versionInfoViewContoller, animated: true)
            })
            .disposed(by: disposeBag)
        
        personalInformationMenu.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToPersonalInformationMenu()
            })
            .disposed(by: disposeBag)
        
        signOutMenu.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showSignOutAlert()
            })
            .disposed(by: disposeBag)
        
        opensourceMenu.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToOpensourceViewController()
            })
            .disposed(by: disposeBag)
        
        // MARK: - ViewModel Binding
        
        viewModel.signOutSucceedRelay
            .subscribe(onNext: { [weak self] in
                NDToastView.shared.rx.showText.onNext(.green(text: "로그아웃 되었습니다."))
                self?.navigateToHomeViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToPersonalInformationMenu() {
        navigationController?.pushViewController(PersonalInformationViewController(PersonalInformationViewModel()), animated: true)
    }
    
    private func navigateToHomeViewController() {
        guard let tabBarController = UIApplication.shared.windows.first?.rootViewController as? MainTabBarController else { return }
        tabBarController.selectTab.accept(.home)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func navigateToOpensourceViewController() {
        navigationController?.pushViewController(OpensourceLicenseViewController(BaseViewModel()), animated: true)
    }
    
    private func showSignOutAlert() {
        view.addSubview(signOutAlert)
        signOutAlert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
