//
//  RoadRequestModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

extension PlaceRequestModel {
    struct RoadListModel: Encodable {
        var categoryId: Int?
        var placeCode: Int?
        let limit: Int
        let lastId: String
        let direction: String
        
        enum Direction: String, Encodable {
            case backward
            case forward
        }
      
        /// 카테고리별 필터시
        init(categoryId: Int?, limit: Int = 20, lastId: String, direction: Direction) {
            self.categoryId = categoryId
            self.limit = limit
            self.lastId = lastId
            self.direction = direction.rawValue
        }
        
        /// 주소별 필터시
        init(placeCode: Int?, limit: Int = 20, lastId: String, direction: Direction) {
            self.placeCode = placeCode
            self.limit = limit
            self.lastId = lastId
            self.direction = direction.rawValue
        }
    }
}
