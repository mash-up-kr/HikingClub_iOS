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
    
    func requestEmailAuthCode() {
        // TODO: 이메일 발송 API 작성하기
    }
    
    func isRightAuthCode(_ inputCode: String?) -> Bool {
        // TODO: 서버에 입력된 코드 넘기고, 인증 결과 받아서 처리 로직으로 변경하기
        guard let inputCode = inputCode, inputCode == "1234" else {
            return false
        }
        
        return true
    }
}
