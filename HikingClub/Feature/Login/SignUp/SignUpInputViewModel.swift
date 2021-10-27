//
//  SignUpInputViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/27.
//

import UIKit
import RxRelay

final class SignUpInputViewModel: BaseViewModel {
    
    private var isAllValidate: Bool = false
    private var passwordValidate: Bool = false
    private var passwordConfirmValidate: Bool = false
    
    var enableNextStepRelay = PublishRelay<Bool>()
    var isEnableNextStep: Bool {
        isAllValidate
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
}
