//
//  SettingViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/21.
//

import Foundation
import RxRelay

final class SettingViewModel: BaseViewModel {
    
    let signOutSucceedRelay = PublishRelay<Void>()

    func signOut() {
        UserInformationUserDefault.init(key: .token).removeAll()
        signOutSucceedRelay.accept(Void())
    }
}
