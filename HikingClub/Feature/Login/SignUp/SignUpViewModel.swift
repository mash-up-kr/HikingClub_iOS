//
//  SignUpViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/27.
//

import UIKit
import RxRelay

final class SignUpViewModel: BaseViewModel {
    
    private var isAllAgree: Bool = false
    private var isPersonalAgree: Bool = false
    
    var updateAgreementRelay = PublishRelay<Bool>()
    var isEnableSignUp: Bool {
        isAllAgree
    }
    
    func agree(_ termType: SignUpTermsStackView.SignUpTermType) {
        switch termType {
        case .personal:
            isPersonalAgree.toggle()
        }
        
        updateAgreement()
    }
    
    private func updateAgreement() {
        isAllAgree = false
        
        if isPersonalAgree {
            isAllAgree = true
        }
        
        updateAgreementRelay.accept(isAllAgree)
    }
}
