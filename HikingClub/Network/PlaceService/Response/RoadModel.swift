//
//  RoadModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

struct RoadResponse: Decodable {
    let roads: [Road]
}

struct Road: Decodable {
    let id: String
    let title: String
    let content: String
    let distance: Int
    let place: String
    let category: CategoryIcon
    let routes: [[Int]]
    let spots: [Spot]
    let images: [String]
    let hashtags: [String]
}

struct Spot: Decodable {
    let title: String
    let content: String
    let point: [Int]
}
