//
//  EmailVerificationAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import Moya

enum EmailVerificationAPI {
    case sendToken(EmailVerificationRequestModel.SendTokenModel)
    case verificationEmail(EmailVerificationRequestModel.EmailVerificationModel)
}

extension EmailVerificationAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .sendToken:
            return "/v1/apis/users/token/signUp"
        case .verificationEmail:
            return "/v1/apis/users/verification/token"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .sendToken:
            return .post
        case .verificationEmail:
            return .post
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .sendToken(let body):
            return .requestJSONEncodable(body)
        case .verificationEmail(let body):
            return .requestJSONEncodable(body)
        }
    }
}
