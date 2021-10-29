//
//  ResponseModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import UIKit

protocol ResponseProtocol {
    var responseCode: String { get }
    var message: String { get }
}

/// 단일 모델 Response Wrapepr
struct ResponseModel<T: Decodable>: ResponseProtocol, Decodable {
    var responseCode: String
    let message: String
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "resCode"
        case message
        case data
    }
}

/// 배열 모델 Response Wrapper
struct ListResponseModel<T: Decodable>: ResponseProtocol, Decodable {
    var responseCode: String
    var message: String
    let listData: [T]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "resCode"
        case message
        case listData = "data"
    }
}
