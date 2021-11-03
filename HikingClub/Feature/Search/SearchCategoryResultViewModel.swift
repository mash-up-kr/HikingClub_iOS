//
//  SearchCategoryResultViewModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/03.
//

import Foundation
import RxRelay

final class SearchCategoryResultViewModel: BaseViewModel {
    let roadDatas: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let categoryWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
}
