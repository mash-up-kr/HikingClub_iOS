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
    private lazy var tabbar: CategoryTabCollectionView = {
        let tabbar = CategoryTabCollectionView()
        tabbar.backgroundColor = .gray100
        tabbar.rx.setDelegate(self).disposed(by: disposeBag)
        return tabbar
    }()
    
    override func attribute() {
        super.attribute()
        
        setTableView()
    }
    
    override func bind() {
        super.bind()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        // 길 리스트
        viewModel.roadDatas
            .bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell",
                                         cellType: RoadTableViewCell.self)) { row, cellModel, cell in
                cell.configure(tags: cellModel)
            }
                                         .disposed(by: disposeBag)
        
        // 상단 탭바
        viewModel.locations
            .bind(to: tabbar.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                      cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel)
            }.disposed(by: disposeBag)
        
        // FIXME: - 목데이터 삭제
        viewModel.mockData()
    }
    
    func setTableView() {
        tableView.register(RoadTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        guard let headerView = Bundle.main.loadNibNamed("HitThemeTableHeaderView", owner: nil, options: nil)?.first as? UIView else {
            return nil
        }
        
        containerView.addSubViews(headerView, tabbar)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(174)
        }
        tabbar.snp.remakeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
            $0.bottom.equalToSuperview()
        }
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 231
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = viewModel.locations.value[indexPath.item]
        return tabbar.cellSize(text: word)
    }
}
