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
    
    override func attribute() {
        super.attribute()
        
        tableView.register(RoadTableViewCell.self)
        tableView.register(headerFooter: HitThemeTableHeaderView.self)
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HitThemeTableHeaderView.self))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 223
    }
}
