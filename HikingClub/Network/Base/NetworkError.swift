//
//  NetworkError.swift
//  HikingClub
//
//  Created by 남수김 on 2021/09/25.
//

import Foundation

enum NetworkError: Error {
    case httpStatus(HttpStatus)
    case jsonSerialization
    case objectMapping(String)
    case invalidToken
    
    
    var description: String {
        switch self {
        case .httpStatus(let status):
            return status.description
        case .jsonSerialization:
            return "JSON Serialization"
        case .objectMapping(let reason):
            return reason
        case .invalidToken:
            return "유효하지 않은 토큰입니다"
        }
    }
    
    /// Http Status Code에 따른 Status Case
    public enum HttpStatus {
        /// 100 - 199 사이의 100 번대 Status
        case conditionalResponse
        /// 200 - 299 사이의 200 번대 Status
        case success
        /// 300 - 399 사이의 300 번대 Status
        case redirection
        /// 400 - 499 사이의 400 번대 Status
        case badRequestError
        /// 500 - 599 사이의 500 번대 Status
        case serverSideError
        /// 명시되지 않은 Status
        case other

        /// 각 case에 대한 description
        var description: String {
            switch self {
            case .conditionalResponse:
                return "ConditionalResponse"
            case .success:
                return "Success"
            case .redirection:
                return "Redirection"
            case .badRequestError:
                return "BadRequestError"
            case .serverSideError:
                return "ServerSideError"
            case .other:
                return "OtherHttpStatusError"
            }
        }

        public static func get(from code: Int) -> HttpStatus {
            switch code {
            case 100..<200:
                return .conditionalResponse
            case 200..<300:
                return .success
            case 300..<400:
                return .redirection
            case 400..<500:
                return .badRequestError
            case ...500:
                return .serverSideError
            default:
                return .other
            }
        }
    }
}

