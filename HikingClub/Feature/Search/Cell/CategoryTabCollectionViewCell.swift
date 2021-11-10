//
//  CategoryTabCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/03.
//

import UIKit

final class CategoryTabCollectionViewCell: UICollectionViewCell {

    private let tabButton: NDTabButton = NDTabButton()
    override var isSelected: Bool {
        didSet {
            tabButton.setSelected(isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(tabButton)
        tabButton.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
        tabButton.setEnabledTouch(false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tabButton.setTitle("")
    }

    func configure(with model: String) {
        tabButton.setTitle(model)
    }
}
