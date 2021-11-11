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
        viewModel.roadDatas.bind(to: tableView.rx.items(cellIdentifier: "RoadTableViewCell", cellType: RoadTableViewCell.self)) { row, cellModel, cell in
            cell.configure(tags: cellModel)
        }
            .disposed(by: disposeBag)
        
        // FIXME: - 목데이터 삭제
        viewModel.roadDatas.accept([["망리단길"],["문정이바보", "그만졸아"],["메롱길", "단풍길","11111","!11111"],[],["단풍길3","단풍길","단풍길"]])
    }
    
    func setTableView() {
        tableView.register(RoadTableViewCell.self)
        tableView.register(headerFooter: HitThemeTableHeaderView.self)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        Observable.just(["하나","둘","셋"])
            .bind(to: tabbar.rx.items(cellIdentifier: CategoryTabCollectionView.cellIdentifier,
                                              cellType: CategoryTabCollectionViewCell.self)) { item, cellModel, cell in
                cell.configure(with: cellModel)
            }.disposed(by: disposeBag)
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HitThemeTableHeaderView") else {
            return nil
        }
        headerView.backgroundColor = .white
        
        containerView.addSubViews(headerView, tabbar)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(174)
        }
        tabbar.snp.makeConstraints {
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
        let word = ["하나","둘","셋"][indexPath.item]
        return tabbar.cellSize(text: word)
    }
}
