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
    
    private let emailService = EmailVerifiactionService()
    private let userService = UserService()
    
    private let authType: EmailAuthType
    
    enum EmailAuthType {
        case singUp
        case forgotPassword
    }
    
    init(_ authType: EmailAuthType) {
        self.authType = authType
    }
    
    func requestEmailAuthCode(_ email: String) {
        switch authType {
        case .singUp:
            sendEmailForSingUp(email)
        case .forgotPassword:
            sendEmailForChangePassword(email)
        }
    }
    
    private func sendEmailForSingUp(_ email: String) {
        emailService.sendToken(email)
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_SEND_MAIL_SIGN_UP_TOKEN" {
                    self?.toastMessage.accept(.green(text: "인증메일이 전송되었습니다."))
                } else {
                    self?.toastMessage.accept(.red(text: response.message))
                }
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    private func sendEmailForChangePassword(_ email: String) {
        userService.requestChangePassword(for: email)
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_REQUEST_RESET_PASSWORD" {
                    self?.toastMessage.accept(.green(text: "인증메일이 전송되었습니다."))
                } else {
                    self?.toastMessage.accept(.green(text: response.message))
                }
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    func isRightAuthCode(_ email: String, _ code: String) {
        emailService.verificationEmail(.init(email: email,
                                        token: code,
                                        tokenType: authType == .singUp ? .signUp : .forgotPassword))
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_VERIFYING" {
                    self?.authorizeSucceedRelay.accept(email)
                } else {
                    self?.toastMessage.accept(.green(text: response.message))
                }
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
}
