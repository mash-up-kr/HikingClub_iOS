//
//  SearchCategoryResultViewModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/03.
//

import Foundation
import RxRelay

final class SearchCategoryResultViewModel: BaseViewModel {
    // MARK: - Output
    let roadDatas: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let categoryWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    let categoryName: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    // MARK: - Input
    let selectedCategory: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    init(categoryName: String) {
        super.init()
        // FIXME: - mock데이터 삭제
        roadDatas.accept(["1","1","1","1"])
        categoryWords.accept(["가가가가나나나나다다다다라라라라","12","13","14","12345","하하하하하하하하하하ㅏ"])
        
        bind()
    }
    
    private func bind() {
        selectedCategory
            .filter { [weak self] in 0 <= $0 && $0 < self?.categoryWords.value.count ?? 0 }
            .subscribe(onNext: { [weak self] index in
                guard let word = self?.categoryWords.value[index] else { return }
                self?.categoryName.accept(word)
            })
            .disposed(by: disposeBag)
    }
}
