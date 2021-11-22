//
//  API.swift
//  HikingClub
//
//  Created by 남수김 on 2021/09/25.
//

import Foundation
import Moya

// MARK: - API정의
enum API {
    /// 테스트경로
    case mock
}

extension API: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .mock:
            return ""
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .mock:
            return .get
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .mock:
            return .requestPlain
        }
    }
}

// MARK: - 디폴트 값
extension TargetType {
    var baseURL: URL {
        URL(string: "https://api.nadeulgil.com")!
    }
    
    var headers: [String : String]? {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserInformationUserDefault.init(key: .token).value ?? "")"
        ]
    }
}

