//
//  VersionInfoViewModel.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/13.
//

import Foundation
import RxRelay

final class VersionInfoViewModel: BaseViewModel {
    let versionInfo: BehaviorRelay<[String]> = BehaviorRelay(value: [])
}
