//
//  PlaceService.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import RxSwift
import Moya
import RxMoya

struct PlaceService {
    private let provider = NetworkProvider<PlaceAPI>()
    
    typealias PlaceSearchListResponse = ListResponseModel<PlaceModel>
    typealias CategoriesResponse = ListResponseModel<CategoryModel>
    typealias RoadsResponse = ResponseModel<RoadResponse>
    
    func search(_ keyword: String) -> Single<PlaceSearchListResponse> {
        provider.request(.search(PlaceRequestModel.SearchModel(keyword: keyword)))
    }
    
    func search(_ model: PlaceRequestModel.SearchModel) -> Single<PlaceSearchListResponse> {
        provider.request(.search(model))
    }
    
    func categories() -> Single<CategoriesResponse> {
        provider.request(.categories)
    }
    
    func roads(model: PlaceRequestModel.RoadListModel) -> Single<RoadsResponse> {
        provider.request(.roadList(model))
    }
    
    func myRoads(_ model: PlaceRequestModel.MyRoadModel) -> Single<RoadsResponse> {
        provider.request(.myRoads(model))
    }
}
