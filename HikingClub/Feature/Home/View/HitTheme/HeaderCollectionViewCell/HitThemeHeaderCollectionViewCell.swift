//
//  HitThemeHeaderCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//

import UIKit

final class HitThemeHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var model: CategoryModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(_ model: CategoryModel) {
        self.model = model
        imageView.image = model.key.themeImage(scale: .small)
    }
}
