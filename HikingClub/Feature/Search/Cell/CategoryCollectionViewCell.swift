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
    
    var title: String {
        switch self {
        case .cherryBlossom: return "벚꽃"
        case .children: return "어린이"
        case .couple: return "연인"
        case .exercise: return "운동"
        case .food: return "먹거리"
        case .lake: return "호수"
        case .nature: return "자연"
        case .nightView: return "야경"
        case .pet: return "반려견"
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
        imageView.setImage(.icon_crossX_gray700_16)
        backgroundColor = .gray100
        layer.cornerRadius = 8
    }
    
    func configure(with model: CategoryModel) {
        titleLabel.text = model.name
        imageView.image = model.key.icon
    }
}
