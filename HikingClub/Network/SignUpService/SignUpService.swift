//
//  SignUpService.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/13.
//

import RxSwift
import Moya
import RxMoya

struct SignUpService {
    private let provider = NetworkProvider<SignUpAPI>()
    
    func sendToken(_ email: String) -> Single<BaseResponseModel> {
        provider.request(.sendToken(SignUpRequestModel.SendTokenModel(email: email)))
    }
    
    func verificationEmail(_ model: SignUpRequestModel.EmailVerificationModel) -> Single<BaseResponseModel> {
        provider.request(.verificationEmail(model))
    }
    
    func signUp(_ model: SignUpRequestModel.SignUpModel) -> Single<BaseResponseModel> {
        provider.request(.singUp(model))
    }
}
