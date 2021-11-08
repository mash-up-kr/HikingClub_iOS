//
//  SearchResultViewModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/06.
//

import Foundation
import RxRelay

final class SearchResultViewModel: BaseViewModel {
    // MARK: - Output
    let roadDatas: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let locations: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let searchWord: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    // MARK: - Input
    // TODO: - 위치정보로 변경
    let selectedLocationIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    init(searchWord: String) {
        super.init()
        // FIXME: - mock데이터 삭제
        roadDatas.accept(["1","1","1","1"])
        locations.accept(["현위치","가락동","송파구","서울","12345","하하하하하하하하하하ㅏ"])
        self.searchWord.accept(searchWord)
        bind()
    }
    
    private func bind() {
        selectedLocationIndex
            .filter { [weak self] in 0 <= $0 && $0 < self?.locations.value.count ?? 0 }
            .subscribe(onNext: { 
                // TODO: - 위치변경 통신
                print("위치변경 index: \($0)")
            })
            .disposed(by: disposeBag)
    }
}
