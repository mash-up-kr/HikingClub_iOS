//
//  HitThemeHeaderCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//

import UIKit

final class HitThemeHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: CategoryModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setFont(.semiBold16)
        layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(_ model: CategoryModel) {
        self.model = model
        titleLabel.text = model.name
        imageView.image = model.key.themeImage
    }
}
