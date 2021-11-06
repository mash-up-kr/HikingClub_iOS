//
//  HomeViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/06.
//

import Foundation
import RxRelay

final class HomeViewModel: BaseViewModel {
    let roadDatas: BehaviorRelay<[[String]]> = BehaviorRelay(value: [])
   
}
