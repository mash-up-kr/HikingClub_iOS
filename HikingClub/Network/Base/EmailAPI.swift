//
//  EmailAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import Moya

enum EmailAPI {
    case authRequest
}

extension EmailAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .authRequest:
            return ""
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .authRequest:
            return .get
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .authRequest:
            return .requestPlain
        }
    }
}
