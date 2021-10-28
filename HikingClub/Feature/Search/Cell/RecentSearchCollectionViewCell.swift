//
//  RecentSearchCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/28.
//

import UIKit

final class RecentSearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }

    private func attribute() {
        titleLabel.setFont(.regular13)
        titleLabel.textColor = .gray700
        deleteButton.setImage(.icon_crossX_gray700_16)
        deleteButton.setTitle("", for: .normal)
        backgroundColor = .gray100
        layer.cornerRadius = 4
    }
    
    func configure(with model: String) {
        titleLabel.text = model
    }
}
