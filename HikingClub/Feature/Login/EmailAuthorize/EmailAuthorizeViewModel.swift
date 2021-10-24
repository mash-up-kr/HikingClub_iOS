//
//  EmailAuthorizeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import UIKit

class EmailAuthorizeViewModel: BaseViewModel {
    enum RequestFor {
        case signUp
        case forgotPassword
    }
    private var requestedFor: RequestFor
    
    init(_ requestFor: RequestFor) {
        requestedFor = requestFor
        super.init()
    }
    
    func requestEmailAuth() {
        // TODO: business logic 작성하기 
    }
}
