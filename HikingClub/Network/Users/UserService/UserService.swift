//
//  UserService.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import RxSwift
import Moya
import RxMoya

struct UserService {
    private let provider = NetworkProvider<UserAPI>()
    
    func requestChangePassword(for email: String) -> Single <BaseResponseModel> {
        provider.request(.requestResetPassword(UserRequestModel.ResetPasswordModel(email: email, password: nil)))
    }
    
    func changePassword(_ body: UserRequestModel.ResetPasswordModel) -> Single<BaseResponseModel> {
        provider.request(.resetPassword(body))
    }
}
