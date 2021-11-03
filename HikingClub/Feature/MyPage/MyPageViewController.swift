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
        // TODO: 아이콘 변경하기
        let view = NaviBar()
        view.setTitle("마이페이지")
        view.setRightItemImage(.icon_magnifier_left_gray900_24)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RoadTableViewCell.self)
        tableView.tableHeaderView = nickNameHeaderView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        return tableView
    }()
    
    // TODO: Component로 분리하기
    private let nickNameHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: 68))
        view.backgroundColor = .gray50
        
        let label = UILabel()
        label.text = "둘레길 마스터"
        label.setFont(.semiBold24)
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(7)
        }
        return view
    }()
    
    // TODO: Component로 분리하기
    private let tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: 46))
        view.backgroundColor = .gray50
        
        let headerButtonView = MyPageListHeaderButtonView()
        headerButtonView.setSelected(.myList)
        
        let countLabel = UILabel()
        countLabel.setFont(.semiBold16)
        countLabel.textColor = .green500
        countLabel.text = "1155개"
        
        view.addSubViews(headerButtonView, countLabel)
        headerButtonView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(7)
        }
        return view
    }()
    
    // MARK: - Layout
    
    override func layout() {
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
        navigationController?.pushViewController(SettingViewController(BaseViewModel()), animated: true)
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
