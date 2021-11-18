//
//  SignUpRequestModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import Foundation

enum SignUpRequestModel {
    struct SignUpModel: Encodable {
        var email: String = ""
        var password: String = ""
        var nickname: String = ""
        var placeCode: String = ""
    }
}
