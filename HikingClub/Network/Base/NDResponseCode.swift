//
//  NDResponseCode.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/28.
//

import Foundation

enum NDResponseCode: String {
    case failed_auth = "FAILED_AUTHORIZATION"
    case not_fonud_email = "NOT_FOUND_EMAIL"
    case invalid_password = "INVALID_PASSWORD"
    case already_exist_email = "ALREADY_EXIST_EMAIL"
    case already_exist_nickname = "ALREADY_EXIST_NICKNAME"
    case not_found_token = "NOT_FOUND_TOKEN"
    case send_mail_error = "SEND_MAIL_ERROR"
    case undefined_error
    
    var message: String {
        switch self {
        case .failed_auth:
            return "유효하지 않은 토큰입니다."
        case .not_fonud_email:
            return "이메일을 찾을 수 없습니다."
        case .invalid_password:
            return "비밀번호가 틀렸습니다."
        case .already_exist_email:
            return "이미 존재하는 이메일 입니다."
        case .already_exist_nickname:
            return "이미 존재하는 닉네임 입니다."
        case .not_found_token:
            return "존재하지 않는 토큰입니다."
        case .send_mail_error:
            return "이메일 발송에 실패했습니다."
        case .undefined_error:
            return "알 수 없는 오류입니다."
        }
    }
    
    static func responseCodeMessaging<T: ResponseProtocol>(_ response: T,
                                                         _ allowCode: String,
                                                         _ allowMessage: String? = nil,
                                                         _ completionHandler: @escaping (() -> Void)) {
        if response.responseCode == allowCode {
            NDToastView.shared.rx.showText.onNext(.green(text: allowMessage ?? response.message))
            completionHandler()
        } else {
            let code = NDResponseCode(rawValue: response.responseCode) ?? .undefined_error
            NDToastView.shared.rx.showText.onNext(.red(text: code.message))
        }
    }
}
