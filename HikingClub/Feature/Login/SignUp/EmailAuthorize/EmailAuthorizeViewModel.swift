//
//  EmailAuthorizeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import UIKit
import RxRelay

class EmailAuthorizeViewModel: BaseViewModel {
    let authorizedEmailRelay = PublishRelay<String>()
    
    let authorizeSucceedRelay = PublishRelay<String>()
    
    private let service = SignUpService()
    
    func requestEmailAuthCode(_ email: String) {
        service.sendToken(email)
            .subscribe(onSuccess: { response in
                if response.responseCode == "SUCCESS_SEND_MAIL_SIGN_UP_TOKEN" {
                    NDToastView.shared.rx.showText.onNext(.green(text: "인증메일이 전송되었습니다."))
                } else {
                    let message = response.message
                    NDToastView.shared.rx.showText.onNext(.red(text: message))
                }
            }, onFailure: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    func isRightAuthCode(_ email: String, _ code: String) {
        service.verificationEmail(.init(email: email,
                                        token: code,
                                        tokenType: .signUp))
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_VERIFYING" {
                    self?.authorizeSucceedRelay.accept(email)
                } else {
                    let message = response.message
                    NDToastView.shared.rx.showText.onNext(.red(text: message))
                }
            }, onFailure: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
}
