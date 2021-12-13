//
//  BaseViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    let toastMessage = PublishRelay<NDToastView.Theme>()
}
