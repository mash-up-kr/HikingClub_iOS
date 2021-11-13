//
//  InitialCategorySettingViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/11.
//

import RxRelay

final class InitialCategorySettingViewModel: BaseViewModel {
    let categoryWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    override init() {
        categoryWords.accept(["자연", "야경","벚꽃","연인","자전거","산악회","먹거리","호수","네글자는","한줄더"])
    }
}
