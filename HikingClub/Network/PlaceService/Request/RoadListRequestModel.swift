//
//  RoadRequestModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

extension PlaceRequestModel {
    struct RoadListModel: Encodable {
        var categoryId: String?
        var placeCode: Int?
        let limit: Int
        let lastId: String
        let direction: String
        
        /// 필터종류
        var filter: Filter
        
        enum Direction: String, Encodable {
            case backward
            case forward
        }
        
        enum Filter: Encodable {
            case category
            case place
        }
        
        /// 카테고리별 필터시
        init(categoryId: String?, limit: Int = 10, lastId: String, direction: Direction) {
            self.categoryId = categoryId
            self.limit = limit
            self.lastId = lastId
            self.direction = direction.rawValue
            self.filter = .category
        }
        
        /// 주소별 필터시
        init(placeCode: Int?, limit: Int = 10, lastId: String, direction: Direction) {
            self.placeCode = placeCode
            self.limit = limit
            self.lastId = lastId
            self.direction = direction.rawValue
            self.filter = .place
        }
        
        var queryString: String {
            var queries = self.dictionary
            queries.removeValue(forKey: "filter")
            return queries.queryString
        }
    }
}
