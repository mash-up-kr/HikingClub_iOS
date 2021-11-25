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
        var pageSize: Int = 30
        var long: Double?
        var lat: Double?
        
        enum CodingKeys: String, CodingKey {
            case keyword
            case pageSize
            case long = "position_y"
            case lat = "position_x"
        }
        
        init(lat: Double, long: Double) {
            self.lat = lat
            self.long = long
        }
        
        init(keyword: String) {
            self.keyword = keyword
        }
    }
    
    struct MyRoadModel: Encodable {
        var page: Int = .zero
        let pageSize: Int = 30
    }
}
