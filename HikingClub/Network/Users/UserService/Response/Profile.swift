//
//  Profile.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/22.
//

import UIKit

struct Profile: Decodable {
    let email: String
    let nickname: String
    let imageURL: String?
    let places: PlaceModel?
    let favoriteCategories: [CategoryModel]
    
    enum CodingKeys: String, CodingKey {
        case email
        case nickname
        case imageURL = "profileImageUrl"
        case places
        case favoriteCategories
    }
}
