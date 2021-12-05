//
//  SignUpAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/13.
//

import Moya

enum SignUpAPI {
    case singUp(SignUpRequestModel.SignUpModel)
}

extension SignUpAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .singUp:
            return "/v1/apis/users"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .singUp:
            return .post
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .singUp(let body):
            return .requestJSONEncodable(body)
        }
    }
}
