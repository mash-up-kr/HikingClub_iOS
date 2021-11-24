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
    
    private var canRequestMoreRoads: Bool = false
    private var needResetRoadDatas: Bool = false
    
    /// 길목록
    private var myRoadRequestModel = PlaceRequestModel.MyRoadModel()
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    let roadRequestFinised = PublishRelay<Void>()
    
    /// 유저 정보
    let userInformation = BehaviorRelay<Profile?>(value: nil)
    
    override init() {
        super.init()
        baseBinding()
    }
    
    private func baseBinding() {
        UserInformationManager.shared.isSignedOut
            .subscribe(onNext: { [weak self] in
                self?.resetInformation()
            })
            .disposed(by: disposeBag)
        
        requestMyRoads()
    }
    
    private func resetInformation() {
        userInformation.accept(nil)
        
        resetRoadInformation()
    }
    
    private func resetRoadInformation() {
        canRequestMoreRoads = false
        needResetRoadDatas = false
        myRoadRequestModel.page = 1
        roadDatas.accept([])
    }
    
    func requestMyRoads(needReset: Bool = false) {
        resetRoadRequest(needReset)
        
        placeService.myRoads(myRoadRequestModel)
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.processRoadsResponse($0)
                self?.roadRequestFinised.accept(Void())
            }, onError: { [weak self] _ in
                self?.roadRequestFinised.accept(Void())
                NDToastView.shared.rx.showText.onNext(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    private func resetRoadRequest(_ needReset: Bool) {
        if needReset {
            myRoadRequestModel.page = 1
            needResetRoadDatas = true
        } else {
            myRoadRequestModel.page += 1
        }
    }
    
    func requestMoreRoads(_ indexPath: IndexPath) {
        guard indexPath.row == roadDatas.value.count - 1, canRequestMoreRoads else { return }
        requestMyRoads()
    }
    
    private func processRoadsResponse(_ roads: [Road]) {
        checkCanMoreRequests(roads)
        if needResetRoadDatas {
            roadDatas.accept(roads)
            needResetRoadDatas = false
        } else {
            var current = roadDatas.value
            current.append(contentsOf: roads)
            roadDatas.accept(current)
        }
    }
    
    private func checkCanMoreRequests(_ roads: [Road]) {
        if roads.count < myRoadRequestModel.pageSize || (roads.count == .zero || roads.isEmpty) {
            canRequestMoreRoads = false
        } else {
            canRequestMoreRoads = true
        }
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
