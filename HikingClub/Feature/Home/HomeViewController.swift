//
//  HomeViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    private lazy var locationTabbar: CategoryTabCollectionView = {
        let tabbar = CategoryTabCollectionView()
        tabbar.contentInset = .init(top: 0, left: 16, bottom: 0, right: 70)
        tabbar.rx.setDelegate(self).disposed(by: disposeBag)
        return tabbar
    }()
    // TODO: - 추후 추가해야할 기능
    /// 위치 추가버튼 그라데이션 배경
//    private lazy var locationMoreButtonContainerView: UIView = {
//        let view = UIView(frame: .init(x: 0, y: 0, width: 68, height: 57))
//        let leftColor = UIColor.gray100.withAlphaComponent(0).cgColor
//        let rightColor = UIColor.gray100.cgColor
//        view.addGradientXColor(colors: [leftColor, rightColor])
//        return view
//    }()
    
    // TODO: - 추후 추가해야할 기능
    /// 위치 추가 버튼
//    private lazy var locationMoreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.tintColor = .gray900
//        button.setImage(.icon_plus_gray900_24)
//        return button
//    }()
    private lazy var emptyView: EmptyView = EmptyView()
 
    override func attribute() {
        super.attribute()
        
        setTableView()
        emptyView.isHidden = true
        emptyView.backgroundColor = .clear
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        tableView.prefetchDataSource = self
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // 길 리스트
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(model: cellModel)
            }.disposed(by: disposeBag)
        
        viewModel.roadDatas
            .map { !$0.isEmpty }
            .bind(to: emptyView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.roadDatas
            .map { !$0.isEmpty }
            .bind(to: tableView.rx.isScrollEnabled)
            .disposed(by: disposeBag)
        
        // 길 리스트 클릭
        tableView.rx.itemSelected
            .asDriver()
            .debounce(.milliseconds(300))
            .compactMap { [weak self] in self?.viewModel.roadDatas.value[$0.row].id }
            .drive(onNext: { [weak self] in
                let viewModel = WebViewModel(for: .detail(roadId: $0))
                let viewController = WebViewController(viewModel)
                viewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        // 상단 탭바
        viewModel.locations
            .bind(to: locationTabbar.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                      cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel, subTitle: item == 0 ? "현위치" : nil)
            }.disposed(by: disposeBag)
        
        // TODO: - 선택시 통신
        locationTabbar.rx.itemSelected
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        // TODO: - 추후 추가해야할 기능
//        locationMoreButton.rx.tap
//            .subscribe(onNext: {
//                print("more 클릭")
//            })
//            .disposed(by: disposeBag)
        
        // 위치정보
        viewModel.locations
            .asDriver()
            .filter { !$0.isEmpty }
            .drive(onNext: { [weak self] _ in
                self?.locationTabbar.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
            })
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        tableView.register(RoadTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        guard let headerView = Bundle.main.loadNibNamed("HitThemeTableHeaderView", owner: nil, options: nil)?.first as? HitThemeTableHeaderView else {
            return nil
        }
        
        // TODO: - 추후 추가해야할 기능
        // locationMoreButtonContainerView 추가하기
        containerView.addSubViews(headerView, locationTabbar)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(174)
        }
        
        locationTabbar.snp.remakeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
            $0.bottom.equalToSuperview()
        }
        // TODO: - 추후 추가해야할 기능
//        locationMoreButtonContainerView.snp.remakeConstraints {
//            $0.trailing.equalTo(locationTabbar)
//            $0.height.equalTo(locationTabbar)
//            $0.width.equalTo(68)
//            $0.centerY.equalTo(locationTabbar)
//        }
        // TODO: - 추후 추가해야할 기능
//        locationMoreButtonContainerView.addSubview(locationMoreButton)
//        locationMoreButton.snp.remakeConstraints {
//            $0.trailing.equalToSuperview().inset(16)
//            $0.centerY.equalToSuperview()
//            $0.width.height.equalTo(24)
//        }
        
        viewModel.categoryWords
            .bind(to: headerView.rx.categories)
            .disposed(by: headerView.disposeBag)
        
        headerView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath)
                let item = indexPath.item
                let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
                let nextViewController = searchStoryboard.instantiate("SearchCategoryResultViewController") { [weak self] coder -> SearchCategoryResultViewController? in
                    return .init(coder, SearchCategoryResultViewModel(selectedIndex: item, categories: self?.viewModel.categoryWords.value ?? []))
                }
                self?.navigationController?.pushViewController(nextViewController, animated: true)
            })
            .disposed(by: headerView.disposeBag)
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 231
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == viewModel.roadDatas.value.count - 1 {
                viewModel.requestMoreRoads()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.locations.value[indexPath.item]
        return locationTabbar.cellSize(title: word, subTitle: indexPath.item == 0 ? "현위치" : nil)
    }
}
