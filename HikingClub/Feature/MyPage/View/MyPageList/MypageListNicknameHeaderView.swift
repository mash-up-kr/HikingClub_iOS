//
//  MypageListNicknameHeaderView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/06.
//

import UIKit

final class MypageListNicknameHeaderView: CodeBasedView {
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold24)
        return label
    }()
    
    override init() {
        super.init(frame: CGRect(x: .zero, y: .zero, width: UIScreen.main.bounds.width, height: 68))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attribute() {
        super.attribute()
        backgroundColor = .gray50
    }
    
    override func layout() {
        super.layout()
        addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(7)
        }
    }
    
    func setNickname(_ nickname: String) {
        nicknameLabel.text = nickname
    }
}
