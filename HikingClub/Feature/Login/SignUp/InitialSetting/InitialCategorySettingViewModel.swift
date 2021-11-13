//
//  InitialCategorySettingViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/11.
//

import RxRelay

final class InitialCategorySettingViewModel: BaseViewModel {
    let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    
    override init() {
        categoryWords.accept([CategoryModel(id: 1, key: .nightView, name: "야경"), CategoryModel(id: 2, key: .couple, name: "연인")])
    }
}
