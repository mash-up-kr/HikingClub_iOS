//
//  CategoryTabCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/03.
//

import UIKit

final class CategoryTabCollectionViewCell: UICollectionViewCell {

    private let tabButton: NDTabButton = NDTabButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(tabButton)
        tabButton.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tabButton.setTitle("")
    }

    func configure(with model: String) {
        tabButton.setTitle(model)
    }
    
    // TODO: - 버튼 선택상태초기화가능하도록 구현하기
}
