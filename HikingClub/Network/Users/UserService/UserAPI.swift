//
//  UserAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import Moya

enum UserAPI {
    case requestResetPassword(UserRequestModel.ResetPasswordModel)
    case resetPassword(UserRequestModel.ResetPasswordModel)
    case profile
}

extension UserAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case.requestResetPassword:
            fallthrough
        case .resetPassword:
            return "/v1/apis/users/reset/password"
        case .profile:
            return "/v1/apis/users/me"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .requestResetPassword:
            return .post
        case .resetPassword:
            return .put
        case .profile:
            return .get
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .requestResetPassword(let body):
            return .requestJSONEncodable(body)
        case .resetPassword(let body):
            return .requestJSONEncodable(body)
        case .profile:
            return .requestPlain
        }
    }
}
