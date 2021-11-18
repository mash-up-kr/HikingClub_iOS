//
//  ChangePasswordViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/18.
//

import RxRelay

final class ChangePasswordViewModel: BaseViewModel {
    private var isAllValidate: Bool = false
    private var passwordValidate: Bool = false
    private var passwordConfirmValidate: Bool = false
    
    var enableNextStepRelay = PublishRelay<Bool>()
    let changePasswordSucceedRelay = PublishRelay<Void>()
    
    private let service = UserService()
    
    private let userEamil: String
    
    init(_ email: String) {
        userEamil = email
    }
    
    func isValidatePassword(_ text: String?) -> Bool {
        guard let text = text else {
            passwordValidate = false
            return passwordValidate
        }
        
        // 자리수 검사
        guard text.count >= 6 && text.count < 18 else {
            passwordValidate = false
            return passwordValidate
        }
        
        passwordValidate = true
        
        updateStatus()
        return passwordValidate
    }
    
    func isSamePassword(_ text: String?, _ standardPassword: String?) -> Bool {
        guard let text = text, let standardPassword = standardPassword, text == standardPassword else {
            passwordConfirmValidate = false
            return passwordConfirmValidate
        }
        passwordConfirmValidate = true
        
        updateStatus()
        return passwordConfirmValidate
    }
    
    private func updateStatus() {
        isAllValidate = false
        
        guard passwordValidate else {
            enableNextStepRelay.accept(isAllValidate)
            return
        }
        
        guard passwordConfirmValidate else {
            enableNextStepRelay.accept(isAllValidate)
            return
        }
        
        isAllValidate = true
        enableNextStepRelay.accept(isAllValidate)
    }
    
    func changePassword(_ password: String) {
        service.changePassword(.init(email: userEamil,
                                     password: password))
            .subscribe(onSuccess: { [weak self] response in
                if response.responseCode == "SUCCESS_RESET_PASSWORD" {
                    self?.changePasswordSucceedRelay.accept(Void())
                    NDToastView.shared.rx.showText.onNext(.green(text: response.message))
                } else {
                    NDToastView.shared.rx.showText.onNext(.red(text: response.message))
                }
            }, onFailure: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
}
