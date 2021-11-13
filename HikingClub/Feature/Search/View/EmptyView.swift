//
//  EmptyView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/14.
//

import UIKit
import SnapKit
import RxSwift

/// emptyView
final class EmptyView: CodeBasedView {
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setImage(.img_empty)
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.textColor = .gray700
        label.setFont(.semiBold18)
        return label
    }()
    
    override func attribute() {
        super.attribute()
        backgroundColor = .white
    }
    
    override func layout() {
        super.layout()
        addSubViews(emptyImageView, titleLabel)
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(47)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
