//
//  EmailVerificationRequestModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import Foundation

enum EmailVerificationRequestModel {
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
}
