//
//  SelectTownViewModel.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/07.
//

import UIKit
import RxRelay

final class SelectTownViewModel: BaseViewModel {
    
    let searchedTownRelay = BehaviorRelay<[String]>(value: ["1동","2동","3동","5동","6동","7동","8동","10동","11동","12동","13동","14동"])

    func fetchTown(_ keyword: String) {
        
    }
}
