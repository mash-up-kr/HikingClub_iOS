//
//  UserInformationManager.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/23.
//

import RxRelay

final class UserInformationManager {
    static let shared = UserInformationManager()
    
    private let userDefault = UserInformationUserDefault.init(key: .token)
    
    private init() { }
    
    var isSingIn: Bool {
        userDefault.isEmpty
    }
    
    var token: String? {
        userDefault.value
    }
    
    var isSignedOut = PublishRelay<Void>()
    
    func signIn(_ token: String) {
        userDefault.save(token)
    }
    
    func singOut() {
        userDefault.removeAll()
        isSignedOut.accept(Void())
    }
}
