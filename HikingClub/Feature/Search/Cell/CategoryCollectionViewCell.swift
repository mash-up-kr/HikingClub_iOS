//
//  CategoryCollectionViewCell.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/29.
//

import UIKit

enum CategoryIcon: String, Decodable {
    case nature = "NATURE"
    case nightView = "NIGHT_VIEW"
    case lake = "LAKE"
    case cherryBlossom = "CHERRY_BLOSSOM"
    case exercise = "EXERCISE"
    case food = "FOOD"
    case couple = "LOVER"
    case children = "CHILD"
    case pet = "PET_DOG"
    
    var icon: UIImage? {
        switch self {
        case .nature: return AssetImage.icon_category_trees_28.image
        case .nightView: return AssetImage.icon_category_moonStar_28.image
        case .cherryBlossom: return AssetImage.icon_category_lake_28.image
        case .children: return AssetImage.icon_category_kindergartenHat_28.image
        case .couple: return AssetImage.icon_category_heart_28.image
        case .exercise: return AssetImage.icon_category_sneakers_28.image
        case .food: return AssetImage.icon_category_bungeoppang_28.image
        case .lake: return AssetImage.icon_category_lake_28.image
        case .pet: return AssetImage.icon_category_dog_28.image
        }
    }

    enum Scale: String {
        case large
        case small
    }
    
    func themeImage(scale: Scale) -> UIImage? {
        scale == .large ? themeLargeImage : themeSmallImage
    }
     
    private var themeSmallImage: UIImage? {
        switch self {
        case .nature:
            return AssetImage.img_category_trees_small.image
        case .nightView:
            return AssetImage.img_category_moonStar_small.image
        case .lake:
            return AssetImage.img_category_lake_small.image
        case .cherryBlossom:
            return AssetImage.img_category_cherryBlossoms_small.image
        case .exercise:
            return AssetImage.img_category_sneakers_small.image
        case .food:
            return AssetImage.img_category_bungeoppang_small.image
        case .couple:
            return AssetImage.img_category_heart_small.image
        case .children:
            return AssetImage.img_category_kindergartenHat_small.image
        case .pet:
            return AssetImage.img_category_dog_small.image
        }
    }
    
    private var themeLargeImage: UIImage? {
        switch self {
        case .nature:
            return AssetImage.img_category_trees_large.image
        case .nightView:
            return AssetImage.img_category_moonStar_large.image
        case .lake:
            return AssetImage.img_category_lake_large.image
        case .cherryBlossom:
            return AssetImage.img_category_cherryBlossoms_large.image
        case .exercise:
            return AssetImage.img_category_sneakers_large.image
        case .food:
            return AssetImage.img_category_bungeoppang_large.image
        case .couple:
            return AssetImage.img_category_heart_large.image
        case .children:
            return AssetImage.img_category_kindergartenHat_large.image
        case .pet:
            return AssetImage.img_category_dog_large.image
        }
    }
}

// TODO: 카테고리별 키값에맞게 이미지 넣어주기

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
        backgroundColor = .gray50
        layer.cornerRadius = 8
    }
    
    func configure(with model: CategoryModel) {
        titleLabel.text = model.name
        imageView.image = model.key.icon
    }
}
