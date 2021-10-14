//
//  GreetingView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit

final class GreetingView: CodeBasedView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold24)
        label.textColor = .black
        label.text = "나들길에 오신걸 환영합니다."
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold16)
        label.textColor = .lightGray
        label.text = "서비스 이용을 위해 약관에 동의해주세요."
        label.numberOfLines = .zero
        return label
    }()
    
    override func layout() {
        super.layout()
        addSubViews(titleLabel, contentLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
