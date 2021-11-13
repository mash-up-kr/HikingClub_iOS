//
//  SignUpAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/13.
//

import Moya

enum SignUpAPI {
    case sendToken(SignUpRequestModel.SendTokenModel)
    case verificationEmail(SignUpRequestModel.EmailVerificationModel)
    case singUp(SignUpRequestModel.SignUpModel)
}

extension SignUpAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .sendToken:
            return "/v1/apis/users/token/signUp"
        case .verificationEmail:
            return "/v1/apis/users/verification/token"
        case .singUp:
            return "/v1/apis/users/create"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .sendToken:
            return .post
        case .verificationEmail:
            return .post
        case .singUp:
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
        case .singUp(let body):
            return .requestJSONEncodable(body)
        }
    }
}

// TODO: REFACTOR

enum SignUpRequestModel {
    struct SendTokenModel: Encodable {
        let email: String
    }
    
    struct EmailVerificationModel: Encodable {
        let email: String
        let token: String
        let tokenType: TokenType
        
        enum TokenType: Int, Encodable {
            case signUp
            case forgotPassword
        }
    }
    
    struct SignUpModel: Encodable {
        var email: String = ""
        var password: String = ""
        var nickname: String = ""
        var placeCode: String = ""
    }
}

