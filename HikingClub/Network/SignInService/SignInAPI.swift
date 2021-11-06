//
//  SignInAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/31.
//

import Moya

enum SignInAPI {
    case signIn(_ model: SignInRequestModel)
}

extension SignInAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .signIn:
            return "/v1/apis/users/login"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .signIn(let model):
            return .requestJSONEncodable(model)
        }
    }
}
