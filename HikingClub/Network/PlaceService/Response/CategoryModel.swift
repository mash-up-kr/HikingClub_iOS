//
//  CategoryModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/14.
//

import Foundation

struct CategoryModel: Decodable {
    let id: Int
    let key: CategoryIcon
    let name: String
}
