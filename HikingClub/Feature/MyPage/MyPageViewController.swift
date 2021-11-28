//
//  MyPageViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/26.
//

import UIKit
import RxSwift

final class MyPageViewController: BaseViewController <MyPageViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("마이페이지")
        view.setRightItemImage(.icon_threeLines_horizon_gray900_24)
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.register(RoadTableViewCell.self)
        tableView.backgroundColor = .gray50
        tableView.refreshControl = refreshControl
        tableView.tableHeaderView = nicknameHeaderView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        return tableView
    }()
    private let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .green700
        return view
    }()
    private let nicknameHeaderView = MypageListNicknameHeaderView()
    private let tableHeaderView = MypageListSectionHeaderView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserInformationManager.shared.isSingIn {
            viewModel.requestProfile()
        }
    }
    
    // MARK: - Attribute
    
    override func attribute() {
        super.attribute()
        nicknameHeaderView.setNickname("-")
        tableHeaderView.setCount(0)
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

        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.requestMyRoads(needReset: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] in
                self?.viewModel.requestMoreRoads($0.indexPath)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigateToRoadDetailViewController($0)
            })
            .disposed(by: disposeBag)
        
        // MARK: - ViewModel Binding
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(model: cellModel)
            }.disposed(by: disposeBag)
        
        viewModel.roadDatas
            .subscribe(onNext: { [weak self] in
                self?.tableHeaderView.setCount($0.count)
            })
            .disposed(by: disposeBag)
        
        viewModel.userInformation
            .compactMap({ $0 })
            .subscribe(onNext: { [weak self] in
                self?.setProfile($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.roadRequestFinised
            .subscribe(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSettingViewController() {
        let viewController = SettingViewController(SettingViewModel())
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func navigateToRoadDetailViewController(_ indexPath: IndexPath) {
        let road = viewModel.roadDatas.value[indexPath.row].id
        let viewModel = WebViewModel(for: .detail(roadId: road))
        let viewController = WebViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setProfile(_ profile: Profile) {
        nicknameHeaderView.setNickname(profile.nickname)
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
}
