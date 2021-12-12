//
//  ChangePasswordViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import RxRelay
import RxSwift

final class ChangePasswordViewModel: BaseViewModel {
    let passwordValidateRelay = BehaviorRelay<Bool>(value: false)
    let passwordConfirmRelay = BehaviorRelay<Bool>(value: false)
    
    var enableNextStepRelay = PublishRelay<Bool>()
    let changePasswordSucceedRelay = PublishRelay<Void>()
    
    private let service = UserService()
    
    private let userEamil: String
    
    init(_ email: String) {
        userEamil = email
        super.init()
        baseBinding()
    }
    
    private func baseBinding() {
        updateStatus()
    }
    
    func validatePassword(_ text: String?) {
        guard
            let text = text, false == text.isEmpty,
            text.count >= 6, text.count < 18
        else {
            passwordValidateRelay.accept(false)
            return
        }
        passwordValidateRelay.accept(true)
    }
   
    func confirmPassword(_ text: String?, _ standardPassword: String?) {
        guard
            let text = text, false == text.isEmpty,
            let standardPassword = standardPassword, false == standardPassword.isEmpty,
            text == standardPassword
        else {
            passwordConfirmRelay.accept(false)
            return
        }
        passwordConfirmRelay.accept(true)
    }
    
    private func updateStatus() {
        Observable.combineLatest(passwordValidateRelay.asObservable(),
                                 passwordConfirmRelay.asObservable())
            .subscribe(onNext: { [weak self] in
                guard $0.0, $0.1 else {
                    self?.enableNextStepRelay.accept(false)
                    return
                }
                self?.enableNextStepRelay.accept(true)
            })
            .disposed(by: disposeBag)
    }
    
    func changePassword(_ password: String) {
        service.changePassword(.init(email: userEamil,
                                     password: password))
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_RESET_PASSWORD" {
                    self?.changePasswordSucceedRelay.accept(Void())
                    self?.toastMessage.accept(.green(text: response.message))
                } else {
                    self?.toastMessage.accept(.red(text: response.message))
                }
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
}
