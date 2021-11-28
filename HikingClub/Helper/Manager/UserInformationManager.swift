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
    
    var isSignIn: Bool {
        !userDefault.isEmpty
    }
    
    var token: String? {
        userDefault.value
    }
    
    var isSignedIn = PublishRelay<Void>()
    var isSignedOut = PublishRelay<Void>()
    
    func signIn(_ token: String) {
        userDefault.save(token)
        isSignedIn.accept(Void())
    }
    
    func singOut() {
        userDefault.removeAll()
        isSignedOut.accept(Void())
    }
}
