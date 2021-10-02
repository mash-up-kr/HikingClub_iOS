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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setFont(.semiBold16)
        titleLabel.text = "단풍길"
    }
}
