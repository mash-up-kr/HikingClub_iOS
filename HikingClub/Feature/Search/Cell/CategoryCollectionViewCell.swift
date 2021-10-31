//
//  CategoryCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/29.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute()
    }
    
    private func attribute() {
        titleLabel.setFont(.semiBold16)
        titleLabel.textColor = .green700
        imageView.setImage(.icon_crossX_gray700_16)
        backgroundColor = .gray100
        layer.cornerRadius = 8
    }
    
    func configure(with model: String) {
        titleLabel.text = model
    }
}
