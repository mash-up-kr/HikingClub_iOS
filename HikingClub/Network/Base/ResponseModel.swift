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

/// data가 확실하게 없는 ResponseModel
struct BaseResponseModel: ResponseProtocol, Decodable {
    var responseCode: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "resCode"
        case message
    }
}

/// 단일 모델 Response Wrapepr
struct ResponseModel<T: Decodable>: ResponseProtocol, Decodable {
    var responseCode: String
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "resCode"
        case message
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseCode = try container.decode(String.self, forKey: .responseCode)
        self.message = try container.decode(String.self, forKey: .message)
        self.data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}

/// 배열 모델 Response Wrapper
struct ListResponseModel<T: Decodable>: ResponseProtocol, Decodable {
    var responseCode: String
    var message: String
    let listData: [T]?
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "resCode"
        case message
        case listData = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.responseCode = try container.decode(String.self, forKey: .responseCode)
        self.message = try container.decode(String.self, forKey: .message)
        self.listData = try container.decodeIfPresent([T].self, forKey: .listData)
    }
}
