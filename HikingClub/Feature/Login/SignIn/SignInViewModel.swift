//
//  SignInViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/31.
//

import UIKit

final class SignInViewModel: BaseViewModel {
    private let service = SignInService()
    
    func requestLogin(_ email: String, _ password: String) {
        service.signIn(SignInRequestModel(email: email, password: password))
            .subscribe(onSuccess: { _ in
                // TODO: 토큰 UD에 저장하고 화면 닫기
            }, onFailure: {
                print($0.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
