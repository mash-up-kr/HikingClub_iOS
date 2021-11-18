//
//  PlaceAPI.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/24.
//

import Moya

enum PlaceAPI {
    case search(PlaceRequestModel.SearchModel)
    case categories
    case roadList(PlaceRequestModel.RoadListModel)
}

extension PlaceAPI: TargetType {
    // MARK: - 경로정의
    var path: String {
        switch self {
        case .search:
            return "/v1/apis/places"
        case .categories:
            return "/v1/apis/categories"
        case .roadList:
            return "/v1/apis/roads"
        }
    }
    
    // MARK: - HTTP형식 정의
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        case .categories:
            return .get
        case .roadList:
            return .get
        }
    }
    
    // MARK: - 데이터정의
    var task: Task {
        switch self {
        case .search(let model):
            return .requestParameters(parameters: model.dictionary, encoding: URLEncoding.default)
        case .categories:
            return .requestPlain
        case .roadList(let model):
            return .requestParameters(parameters: model.dictionary, encoding: URLEncoding.queryString)
        }
    }
}
