//
//  EmailVerifiactionService.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import RxSwift
import Moya
import RxMoya

struct EmailVerifiactionService {
    private let provider = NetworkProvider<EmailVerificationAPI>()
    
    func sendToken(_ email: String) -> Single<BaseResponseModel> {
        provider.request(.sendToken(EmailVerificationRequestModel.SendTokenModel(email: email)))
    }
    
    func verificationEmail(_ model: EmailVerificationRequestModel.EmailVerificationModel) -> Single<BaseResponseModel> {
        provider.request(.verificationEmail(model))
    }
}
