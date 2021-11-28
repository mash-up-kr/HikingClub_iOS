//
//  HomeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxRelay
import RxSwift

final class HomeViewModel: BaseViewModel {
    // MARK: - Output
    /// 길목록
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    /// 위치
    let locations: BehaviorRelay<[PlaceModel]> = BehaviorRelay(value: [])
    /// 카테고리
    let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let placeService = PlaceService()
    private var placeCode: Int = 1123068
    /// 페이징 가능한지체크
    private var isRequestMoreRoads: Bool = true
    private let userInformationUserDefault = UserInformationUserDefault(key: .token)
    
    override init() {
        super.init()
        updateCategory()
    }
    
    /// 주소별 길 리스트 조회
    func requestRoads(index: Int) {
        guard let placeCode = Int(locations.value[index].code) else { return }
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
    
    func updateCategory() {
        if userInformationUserDefault.isEmpty {
            requestCategories()
        } else {
            // TODO: 내정보에있는 카테고리쓰기
        }
    }
    
    /// 카테고리 리스트통신
    private func requestCategories() {
        placeService.categories()
            .subscribe(onSuccess: { [weak self] in
                guard let list = $0.listData else { return }
                self?.categoryWords.accept(list)
            })
            .disposed(by: disposeBag)
    }
    
    // TODO: 내위치 가져오기
    func updateLocation() {
        if userInformationUserDefault.isEmpty {
            currentLocation()
        } else {
            // TODO: 내정보에있는 위치정보쓰기
            
        }
    }
    
    /// 위치정보가져오기
    func currentLocation() {
        NDLocationManager.shared.requestLocationAuth { [weak self] in
            guard let self = self else { return }
            NDLocationManager.shared.rx.didUpdateLocation
                .flatMap { [weak self] in self?.requestAddress(location: $0) ?? .error(RxError.noElements)}
                .catch { _ in .just(PlaceModel(code: "", fullAddress: "알수없음", coords: [])) }
                .subscribe(onNext: { [weak self] in
                    self?.locations.accept([$0])
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    /// 경도위도 통신으로 주소 가져옴
    private func requestAddress(location: (Double, Double)) -> Observable<PlaceModel> {
        var model = PlaceRequestModel.SearchModel(lat: location.0, long: location.1)
        model.pageSize = 1
        return placeService.search(model)
            .compactMap { $0.listData?.first }
            .asObservable()
    }
}
