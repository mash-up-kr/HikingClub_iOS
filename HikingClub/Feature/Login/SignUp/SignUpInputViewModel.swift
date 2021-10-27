//
//  SignUpInputViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/27.
//

import UIKit

final class SignUpInputViewModel: BaseViewModel {

    func isValidatePassword(_ text: String?) -> Bool {
        guard let text = text else { return false }
        
        // 자리수 검사
        guard text.count >= 6 && text.count < 18 else { return false }
        
        return true
    }
    
    func isSamePassword(_ text: String?, _ standardPassword: String) -> Bool {
        guard let text = text, text == standardPassword else {
            return false
        }
        return true
    }
}
