//
//  PlaceRequestModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import UIKit

enum PlaceRequestModel {
    struct SearchModel: Encodable {
        var keyword: String = ""
        var pageSize: Int = 10
    }
}
