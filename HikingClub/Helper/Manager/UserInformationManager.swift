//
//  UserInformationManager.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/23.
//

import RxRelay

struct UserInformationManager {
    static let shared = UserInformationManager()
    
    private init() { }
    
    var isSingIn: Bool {
        UserInformationUserDefault.init(key: .token).isEmpty
    }
    
    var token: String? {
        UserInformationUserDefault.init(key: .token).value
    }
    
    var isSignedOut = PublishRelay<Void>()
    
    func signIn(_ token: String) {
        UserInformationUserDefault.init(key: .token).save(token)
    }
    
    func singOut() {
        UserInformationUserDefault.init(key: .token).removeAll()
        isSignedOut.accept(Void())
    }
}
