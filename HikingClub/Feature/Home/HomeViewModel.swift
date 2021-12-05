//
//  HomeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxRelay
import RxSwift
import CoreLocation

final class HomeViewModel: BaseViewModel {
    // MARK: - Output
    /// 길목록
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    /// 위치 리스트
    let locations: BehaviorRelay<[PlaceModel]> = BehaviorRelay(value: [])
    /// 현재위치
    private let currentLocation: BehaviorRelay<[PlaceModel]> = BehaviorRelay(value: [])
    /// 사용자 정의 위치
    private let userSaveLocation: BehaviorRelay<[PlaceModel]> = BehaviorRelay(value: [])
    
    /// 카테고리
    let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let placeService = PlaceService()
    private let userService = UserService()
    /// 선택한 위치
    private var selectedLocationIndex = 0
    /// 페이징 가능한지체크
    private var isRequestMoreRoads: Bool = true
    let isLocationDenied = BehaviorRelay<Bool?>(value: nil)
    
    override init() {
        super.init()
        bind()
        updateCategory()
    }
    
    func bind() {
        let signIn = UserInformationManager.shared.isSignedIn.asObservable()
        let signOut = UserInformationManager.shared.isSignedOut.asObservable()
        
        // 로그인, 로그아웃시 모델변경
        Observable.merge([signIn, signOut])
            .subscribe(onNext: {[weak self] in
                self?.updateLocation()
            })
            .disposed(by: disposeBag)
        
        // 현재위치, 저장위치 동기화
        Observable.combineLatest(currentLocation, userSaveLocation) { current, save -> [PlaceModel] in
            var list = current
            list.append(contentsOf: save)
            return list
        }
        .filter { !$0.isEmpty }
        .subscribe(onNext: { [weak self] in
            self?.locations.accept($0)
            self?.requestRoads(index: 0)
        })
        .disposed(by: disposeBag)
        
        NDLocationManager.shared.rx.didChangeState
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.updateLocation()
            })
            .disposed(by: disposeBag)
    }
    
    /// 주소별 길 리스트 조회
    func requestRoads(index: Int) {
        guard let placeCode = Int(locations.value[index].code) else { return }
        let model = PlaceRequestModel.RoadListModel(placeCode: placeCode, lastId: nil, direction: .forward)
        selectedLocationIndex = index
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
        guard let lastID = newModel.last?.id,
        let placeCode = Int(locations.value[selectedLocationIndex].code) else { return }
        
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
    
    private func updateCategory() {
        requestCategories()
        // TODO: 내정보에있는 카테고리쓰기
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
    
    /// 내위치 가져오기
    private func updateLocation() {
        if NDLocationManager.shared.locationAuthStatus == .denied {
            isLocationDenied.accept(true)
        } else {
            isLocationDenied.accept(false)
            if !UserInformationManager.shared.isSingIn {
                fetchCurrentLocation()
                userSaveLocation.accept([])
            } else {
                fetchCurrentLocation()
                requestProfile()
            }
        }
    }
    
    /// 위치정보가져오기
    private func fetchCurrentLocation() {
        NDLocationManager.shared.requestLocationAuth { [weak self] in
            guard let self = self else { return }
            
            NDLocationManager.shared.startUpdatingLocation()
            NDLocationManager.shared.rx.didUpdateLocation
                .flatMap { [weak self] in self?.requestAddress(location: $0) ?? .error(RxError.noElements)}
                .catch { _ in .just(PlaceModel(code: "", fullAddress: "알수없음", coords: [])) }
                .subscribe(onNext: { [weak self] in
                    self?.currentLocation.accept([$0])
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
    
    /// 유저프로필 통신에서 위치정보만 가져옴
    private func requestProfile() {
        userService.profile()
            .map { $0.data?.places }
            .subscribe(onSuccess: { [weak self] in
                guard let self = self else { return }
                if let places = $0 {
                    self.userSaveLocation.accept([places])
                } else {
                    self.userSaveLocation.accept([])
                }
            })
            .disposed(by: disposeBag)
    }
}
