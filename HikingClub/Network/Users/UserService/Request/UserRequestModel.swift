//
//  UserRequestModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import Foundation

enum UserRequestModel {
    struct ResetPasswordModel: Encodable {
        let email: String
        let password: String?
    }
}
