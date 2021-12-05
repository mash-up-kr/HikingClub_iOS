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
    
    typealias SignUpResponse = Single<ResponseModel<SignUpResponseModel>>
    
    func signUp(_ model: SignUpRequestModel.SignUpModel) -> SignUpResponse {
        provider.request(.singUp(model))
    }
}
