//
//  HomeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxRelay

final class HomeViewModel: BaseViewModel {
    // MARK: - Output
    let roadDatas: BehaviorRelay<[[String]]> = BehaviorRelay(value: [])
    let locations: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    // FIXME: 더미용 나중에 삭제할것
    func mockData() {
        roadDatas.accept([["망리단길"],["문정이바보", "그만졸아"],["메롱길", "단풍길","11111","!11111"],[],["단풍길3","단풍길","단풍길"]])
        locations.accept(["송파구", "문정동", "가락동", "삼전동", "잠실동", "남양주", "서울시 송파구"])
    }
}
