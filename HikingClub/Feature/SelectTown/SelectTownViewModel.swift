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
            .subscribe(onSuccess: { [weak self] in
                self?.searchedTownListRelay.accept($0.listData)
            }, onFailure: { [weak self] error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func selectTown(_ indexPath: IndexPath) {
        let placeModel = searchedTownListRelay.value[indexPath.row]
        selectedTownRelay.accept(placeModel)
    }
    
    func searchTownWithCurrentLocation() {
        guard let currentCoordinate = currentCoordinate else { return }
        // TODO: lat, long 보내는 API 추가 할 것
    }
}
