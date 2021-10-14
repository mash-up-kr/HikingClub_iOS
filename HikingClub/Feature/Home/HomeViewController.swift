//
//  HomeViewController.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func attribute() {
        super.attribute()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RoadTableViewCell.self)
        tableView.register(headerFooter: HitThemeTableHeaderView.self)
    }
}

extension HomeViewController: UITableViewDelegate { }

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoadTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(tags: viewModel.sampleTags)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: HitThemeTableHeaderView.self))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 223
    }
}
