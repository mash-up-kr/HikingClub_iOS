//
//  MypageListSectionHeaderView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/06.
//

import UIKit

final class MypageListSectionHeaderView: CodeBasedView {
    private let headerButtonView: MyPageListHeaderButtonView = {
        let view = MyPageListHeaderButtonView()
        view.setSelected(.myList)
        return view
    }()
    
    private let listConutLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold16)
        label.textColor = .green500
        return label
    }()
    
    override init() {
        super.init(frame: .init(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: 46))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attribute() {
        backgroundColor = .gray50
    }
    
    override func layout() {
        super.layout()
        addSubViews(headerButtonView, listConutLabel)
        headerButtonView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
        listConutLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(7)
        }
    }
    
    func setCount(_ count: Int) {
        listConutLabel.text = "\(count)개"
    }
}
