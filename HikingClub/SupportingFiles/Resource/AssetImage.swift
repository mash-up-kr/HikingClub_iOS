//
//  AssetImage.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/19.
//

import UIKit

// 프로젝트에서 사용되는 모든 에셋
enum AssetImage: String {
    case icon_angleBracket_down_gray900_24
    case icon_angleBracket_left_gray900_24
    case icon_angleBracket_right_gray500_24
    case icon_angleBracket_right_gray900_24
    case icon_crossX_circle_filled_gray500_24
    case icon_crossX_circle_filled_gray900_24
    case icon_crossX_gray500_24
    case icon_crossX_gray900_24
    case icon_maginfier_left_gray900_24
    case icon_plus_gray900_24
    case icon_textField_angleBracket_right_gray600_24
    case icon_threeDots_horizon_gray900_24
    
    
    var image: UIImage? {
        return UIImage.init(named: self.rawValue)
    }
}
