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
    
    func search(_ keyword: String) -> Single<PlaceSearchListResponse> {
        provider.request(.search(PlaceRequestModel.SearchModel(keyword: keyword)))
    }
}