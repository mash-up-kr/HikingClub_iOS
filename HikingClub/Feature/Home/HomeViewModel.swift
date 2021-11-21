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
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let placeService = PlaceService()
    private var placeCode: Int = 1123068
    /// 페이징 가능한지체크
    private var isRequestMoreRoads: Bool = true
    
    // FIXME: 더미용 나중에 삭제할것
    func mockData() {
        locations.accept(["송파구", "문정동", "가락동", "삼전동", "잠실동", "남양주", "서울시 송파구"])
        
        categoryWords.accept([CategoryModel(id: 1, key: .cherryBlossom, name: "벚꽃"),
                              CategoryModel(id: 2, key: .couple, name: "연인"),
                              CategoryModel(id: 1, key: .food, name: "음식")])
    }
    
    /// 주소별 길 리스트 조회
    func requestRoads() {
        let model = PlaceRequestModel.RoadListModel(placeCode: placeCode, lastId: nil, direction: .forward)
        placeService.roads(model: model)
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.roadDatas.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    /// 주소별 길 리스트 페이징요청
    func requestMoreRoads() {
        if isLoading.value || !isRequestMoreRoads {
            return
        }
        isLoading.accept(true)
        
        var newModel = roadDatas.value
        guard let lastID = newModel.last?.id else { return }
        
        let model = PlaceRequestModel.RoadListModel(placeCode: placeCode, lastId: lastID, direction: .forward)
        placeService.roads(model: model)
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.isRequestMoreRoads = !$0.isEmpty
                $0.forEach { newModel.append($0) }
                self?.roadDatas.accept(newModel)
                self?.isLoading.accept(false)
            }, onError: { [weak self] _ in
                self?.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
