//
//  SearchViewModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/27.
//

import Foundation
import RxRelay
import RxSwift

final class SearchViewModel: BaseViewModel {
    // MARK: - Input
    
    // MARK: - Output
    /// 최근검색어
    let recentSearchWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    /// 카테고리
    let categoryWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
}
