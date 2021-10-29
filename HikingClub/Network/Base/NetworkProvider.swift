//
//  NetworkProvider.swift
//  HikingClub
//
//  Created by 남수김 on 2021/09/25.
//

import Foundation
import RxMoya
import Moya
import RxSwift

/**
 - NOTE: -
 Service클래스를 새로만들고 안에 Provider객체를 생성해서 사용한다
 ``` swift
 // 사용방식
final class HomeService {
    let service = NetworkProvider()
    
    func requestHome() -> Single<Sample> {
        service.request(.mock, type: Sample.self)
    }
}
 ```
 */
final class NetworkProvider<Target: TargetType> {
    private let networkProvider = MoyaProvider<Target>(plugins: [NetworkLogging()])
    
    init() {
        let configure = networkProvider.session.sessionConfiguration
        configure.timeoutIntervalForRequest = 10
    }
    
    func request<T: Decodable>(_ api: Target) -> Single<T> {
        networkProvider.rx.request(api)
            .filter(statusCodes: 200...299)
            .map(T.self)
    }
}

