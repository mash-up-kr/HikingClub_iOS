//
//  PlaceModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import UIKit

struct PlaceModel: Decodable {
    let code: String
    let fullAddress: String
    let coords: [Double]
}
