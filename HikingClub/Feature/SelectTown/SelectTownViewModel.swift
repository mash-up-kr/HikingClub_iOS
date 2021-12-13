//
//  SelectTownViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/07.
//

import UIKit
import RxRelay

final class SelectTownViewModel: BaseViewModel {
    private let placeService = PlaceService()
    
    let searchedTownListRelay = BehaviorRelay<[PlaceModel]>(value: [])
    let selectedTownRelay = PublishRelay<PlaceModel>()
    
    var currentCoordinate:(Double, Double)? = nil

    func searchTown(_ keyword: String) {
        placeService.search(keyword)
            .subscribe(onSuccess: { [weak self] response in
                guard let places = response.listData else { return }
                self?.processPlaceResponse(places)
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    func selectTown(_ indexPath: IndexPath) {
        let placeModel = searchedTownListRelay.value[indexPath.row]
        selectedTownRelay.accept(placeModel)
    }
    
    func searchTownWithCurrentLocation() {
        guard let currentCoordinate = NDLocationManager.shared.currentCoordinate else { return }
        let requestModel = PlaceRequestModel.SearchModel(lat: currentCoordinate.0,
                                                         long: currentCoordinate.1)
        placeService.search(requestModel)
            .subscribe(onSuccess: { [weak self] response in
                guard let places = response.listData else { return }
                self?.processPlaceResponse(places)
            }, onFailure: { [weak self] _ in
                self?.toastMessage.accept(.red(text: "네트워크 오류가 발생했습니다."))
            })
            .disposed(by: disposeBag)
    }
    
    private func processPlaceResponse(_ places: [PlaceModel]) {
        searchedTownListRelay.accept(places)
    }
}
