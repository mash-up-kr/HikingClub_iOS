//
//  SignInViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/31.
//

import UIKit
import RxRelay

final class SignInViewModel: BaseViewModel {
    private let service = SignInService()
    
    let loginSucceededRelay = PublishRelay<Void>()
    
    func requestLogin(_ email: String, _ password: String) {
        service.signIn(SignInRequestModel(email: email, password: password))
            .subscribe(onSuccess: { [weak self] response in
                NDResponseCode.responseCodeMessaging(response, "SUCCESS_LOGIN") {
                    guard let responseData = response.data else { return }
                    UserInformationManager.shared.signIn(responseData.accessToken)
                    self?.loginSucceededRelay.accept(Void())
                }
            }, onFailure: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
}
