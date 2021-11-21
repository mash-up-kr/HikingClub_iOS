//
//  MyPageViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/26.
//

import UIKit
import RxSwift
import RxRelay

final class MyPageViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("마이페이지")
        view.setRightItemImage(.icon_threeLines_horizon_gray900_24)
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RoadTableViewCell.self)
        tableView.tableHeaderView = nicknameHeaderView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        return tableView
    }()
    private let nicknameHeaderView = MypageListNicknameHeaderView()
    private let tableHeaderView = MypageListSectionHeaderView()
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        // FIXME: Mock Data Remove
        nicknameHeaderView.setNickname("둘레길마스터")
        tableHeaderView.setCount(11235)
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, tableView)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapRightItem
            .subscribe(onNext: { [weak self] in
                self?.navigateToSettingViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSettingViewController() {
        let viewController = SettingViewController(SettingViewModel())
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MyPageViewController: UITableViewDelegate {
    
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(RoadTableViewCell.self, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
}
