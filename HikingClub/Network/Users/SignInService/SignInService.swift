//
//  SignInService.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/31.
//

import RxSwift
import Moya
import RxMoya

struct SignInService {
    private let provider = NetworkProvider<SignInAPI>()
    
    typealias SignInResponse = ResponseModel<SignInResponseModel>
        
    func signIn(_ model: SignInRequestModel) -> Single<SignInResponse> {
        provider.request(.signIn(model))
    }
}
