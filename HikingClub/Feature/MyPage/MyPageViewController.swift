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

final class MyPageListHeaderButtonView: CodeBasedView {
    enum ButtonType {
        case myList
        case savedList
    }
    
    private var currentSelectedButton: ButtonType = .myList
    
    private let myListButton: UIButton = {
        let button = MyPageListHeaderButton("나의 길")
        return button
    }()
    
    private let savedListButton: UIButton = {
        let button = MyPageListHeaderButton("저장한 길")
        return button
    }()
    
    let currentSelctedRelay = PublishRelay<ButtonType>()
    
    private let disposeBag = DisposeBag()
    
    override func attribute() {
        super.attribute()
    }
    
    override func layout() {
        addSubViews(myListButton, savedListButton)
        myListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        savedListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(myListButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        myListButton.rx.tap
            .bind { [weak self] in self?.setSelected(.myList) }
            .disposed(by: disposeBag)
        
        savedListButton.rx.tap
            .bind { [weak self] in self?.setSelected(.savedList) }
            .disposed(by: disposeBag)
    }

    func setSelected(_ type: ButtonType) {
        switch type {
        case .myList:
            myListButton.isSelected = true
            savedListButton.isSelected = false
        case .savedList:
            myListButton.isSelected = false
            savedListButton.isSelected = true
        }
    }
}

final class MyPageListHeaderButton: UIButton, CodeBasedProtocol {
    private let barIndicator = UIView()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold18)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updatedSelectStatus()
        }
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        contentLabel.text = title
        barIndicator.isHidden = true
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func layout() {
        addSubViews(contentLabel, barIndicator)
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        barIndicator.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func updatedSelectStatus() {
        contentLabel.textColor = isSelected ? .green500 : .gray300
        barIndicator.backgroundColor = isSelected ? .green500 : .clear
        barIndicator.isHidden = !isSelected
    }
}
