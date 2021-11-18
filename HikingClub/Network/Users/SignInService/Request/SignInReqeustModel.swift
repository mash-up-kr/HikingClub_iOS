//
//  SignInReqeustModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/31.
//

import Foundation

struct SignInRequestModel: Encodable {
    let email: String
    let password: String
}
