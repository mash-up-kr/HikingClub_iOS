//
//  HomeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxRelay

final class HomeViewModel: BaseViewModel {
    // MARK: - Output
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    let locations: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    private let placeService = PlaceService()
    
    // FIXME: 더미용 나중에 삭제할것
    func mockData() {
        locations.accept(["송파구", "문정동", "가락동", "삼전동", "잠실동", "남양주", "서울시 송파구"])
    }
    
    /// 주소별 길 리스트 조회
    func requestRoads() {
        let model = PlaceRequestModel.RoadListModel(placeCode: 1123068, lastId: "", direction: .forward)
        placeService.roads(model: model)
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.roadDatas.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
