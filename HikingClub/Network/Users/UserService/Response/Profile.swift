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
    let places: PlaceModel
    let favoiteCategories: [CategoryModel]
}
