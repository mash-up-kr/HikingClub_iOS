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
    /// 길목록
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    /// 위치
    let locations: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    /// 카테고리
    let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    
    private let placeService = PlaceService()
    
    // FIXME: 더미용 나중에 삭제할것
    func mockData() {
        locations.accept(["송파구", "문정동", "가락동", "삼전동", "잠실동", "남양주", "서울시 송파구"])
        
        categoryWords.accept([CategoryModel(id: 1, key: .cherryBlossom, name: "벚꽃"),
                              CategoryModel(id: 2, key: .couple, name: "연인"),
                              CategoryModel(id: 1, key: .food, name: "음식")])
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
