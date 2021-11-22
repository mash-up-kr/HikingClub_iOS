//
//  MyPageViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/22.
//

import Foundation
import RxRelay

final class MyPageViewModel: BaseViewModel {
    private let placeService = PlaceService()
    private let userService = UserService()
    
    /// 길목록
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    
    /// 유저 정보
    let userInformation = BehaviorRelay<Profile?>(value: nil)
    
    override init() {
        super.init()
        
        baseBinding()
    }
    
    private func baseBinding() {
        if UserInformationUserDefault.init(key: .token).value != nil {
            requestProfile()
            requestMyRoads()
        }
    }
    
    func requestMyRoads() {
        placeService.myRoads()
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.roadDatas.accept($0)
            }, onError: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    func requestProfile() {
        userService.profile()
            .subscribe(onSuccess: { [weak self] in
                self?.userInformation.accept($0.data)
            }, onFailure: { _ in
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
}
