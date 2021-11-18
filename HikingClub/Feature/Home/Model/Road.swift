//
//  Road.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/18.
//

import Foundation

/// 길 목록
struct Road {
    let id: String
    let title: String
    let content: String
    let distance: Float
    let place: String
    let category: CategoryIcon
    let routes: [[Float]]
    let spots: [Spot]
    let images: [String]
    let hashtags: [String]
    
    struct Spot {
        let title: String
        let content: String
        let point: [Float]
        
        init(title: String, content: String, point: [Float]) {
            self.title = title
            self.content = content
            self.point = point
        }

        init(spot: RoadResponse.Road.Spot) {
            self.title = spot.title
            self.content = spot.content
            self.point = spot.point
        }
    }

    init(id: String,
         title: String,
         content: String,
         distance: Float,
         place: String,
         category: CategoryIcon,
         routes: [[Float]],
         spots: [Road.Spot],
         images: [String],
         hashtags: [String]) {
        self.id = id
        self.title = title
        self.content = content
        self.distance = distance
        self.place = place
        self.category = category
        self.routes = routes
        self.spots = spots
        self.images = images
        self.hashtags = hashtags
    }
    
    init(road: RoadResponse.Road) {
        self.id = road.id
        self.title = road.title
        self.content = road.content
        self.distance = road.distance
        self.place = road.place
        self.category = road.category
        self.routes = road.routes
        self.spots = road.spots.map { Spot(spot: $0) }
        self.images = road.images
        self.hashtags = road.hashtags
    }
}
