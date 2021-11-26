//
//  AssetImage.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/19.
//

import UIKit

// 프로젝트에서 사용되는 모든 에셋
enum AssetImage: String {
    
    // MARK: - common
    
    case icon_angleBracket_right_gray700_16
    case icon_angleBracket_down_gray900_24
    case icon_angleBracket_left_gray900_24
    case icon_angleBracket_right_gray500_24
    case icon_angleBracket_right_gray900_24
    
    case icon_crossX_circle_filled_gray500_24
    case icon_crossX_circle_filled_gray900_24
    
    case icon_crossX_gray700_16
    case icon_crossX_gray500_24
    case icon_crossX_gray900_24
    
    case icon_bookMark_deselected_gray200_24
    case icon_bookMark_selected_yellow_24
    
    case icon_check_circle_deselected_gray300_24
    case icon_check_circle_selected_green500_24
    case icon_check_green500_24
    
    case icon_arrow_left_curved_gray900_24
    case icon_exclamation_red500_24
    
    case icon_star_circle_yellow_24
    case icon_star_yellow500_16
    
    case icon_magnifier_left_gray900_24
    case icon_plus_gray900_24
    case icon_threeDots_horizon_gray900_24
    case icon_trashCan_gray900_24
    case icon_footprint_green500_16
    case icon_location_green500_16
    case icon_camera_gray500_28
    case icon_threeLines_horizon_gray400_24
    case icon_threeLines_horizon_gray900_24
    case icon_category_bungeoppang_24
    case icon_category_bungeoppang_28
    case icon_category_cherryBlossoms_24
    case icon_category_cherryBlossoms_28
    case icon_category_dog_24
    case icon_category_dog_28
    case icon_category_heart_24
    case icon_category_heart_28
    case icon_category_kindergartenHat_24
    case icon_category_kindergartenHat_28
    case icon_category_lake_24
    case icon_category_lake_28
    case icon_category_moonStar_24
    case icon_category_moonStar_28
    case icon_category_sneakers_24
    case icon_category_sneakers_28
    case icon_category_trees_24
    case icon_category_trees_28
    case logo_gray
    case img_empty
    // MARK: - tabbar
    
    case icon_tabbar_house_deselected_gray200_28
    case icon_tabbar_house_selected_green900_28
    case icon_tabbar_magnifier_left_deselected_gray200_28
    case icon_tabbar_magnifier_left_selected_green900_28
    case icon_tabbar_pencil_deselected_gray200_28
    case icon_tabbar_pencil_selected_green900_28
    case icon_tabbar_person_deselected_gray200_28
    case icon_tabbar_person_selected_green900_28
    
    // MARK: - contentList
    
    case icon_contentList_bookMark_deselected_gray200_24
    case icon_contentList_bookMark_selected_yellow_24
    
    // MARK: - textfield
    
    case icon_textField_angleBracket_right_gray600_24
    
    // MARK: - my
  
    case icon_my_2location_normal_gray900_24
    case icon_my_2location_normal_green700_24
    
    case icon_my_info_normal_gray900_24
    case icon_my_info_normal_green700_24
    
    case icon_my_lock_normal_gray900_24
    case icon_my_lock_normal_green700_24
    
    case icon_my_loudspeaker_normal_gray900_24
    case icon_my_loudspeaker_normal_green700_24
    
    case icon_my_machine_tool_normal_gray900_24
    case icon_my_machine_tool_normal_green700_24
    
    case icon_my_question_normal_gray900_24
    case icon_my_question_normal_green700_24
    
    case icon_my_trash_normal_gray900_24
    case icon_my_trash_normal_green700_24
    
    case icon_my_unlock_normal_gray900_24
    case icon_my_unlock_normal_green700_24
    
    // MARK: - themeImg
    
    case img_category_bungeoppang_large
    case img_category_bungeoppang_small
    case img_category_cherryBlossoms_large
    case img_category_cherryBlossoms_small
    case img_category_dog_large
    case img_category_dog_small
    case img_category_heart_large
    case img_category_heart_small
    case img_category_kindergartenHat_large
    case img_category_kindergartenHat_small
    case img_category_lake_large
    case img_category_lake_small
    case img_category_moonStar_large
    case img_category_moonStar_small
    case img_category_sneakers_large
    case img_category_sneakers_small
    case img_category_trees_large
    case img_category_trees_small
    
    var image: UIImage? {
        return UIImage.init(named: self.rawValue)
    }
}
