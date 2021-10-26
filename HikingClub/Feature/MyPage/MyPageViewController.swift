//
//  MyPageViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/26.
//

import UIKit

final class MyPageViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("마이페이지")
        // TODO: 아이콘 변경하기
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
        
        let button1 = UIButton()
        button1.setFont(.semiBold18)
        button1.setTitleColor(.green500, for: .normal)
        button1.setTitle("나들길", for: .normal)
        
        let button2 = UIButton()
        button2.setFont(.semiBold18)
        button2.setTitleColor(.green500, for: .normal)
        button2.setTitle("저장한 길", for: .normal)
        
        let countLabel = UILabel()
        countLabel.setFont(.semiBold16)
        countLabel.textColor = .green500
        countLabel.text = "1155개"
        
        view.addSubViews(button1, button2, countLabel)
        button1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(8)
        }
        button2.snp.makeConstraints {
            $0.leading.equalTo(button1.snp.trailing).offset(20)
            $0.bottom.equalToSuperview().inset(8)
        }
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(7)
        }
        return view
    }()
    
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
