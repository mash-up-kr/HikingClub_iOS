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
    let _categoryName: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init(categoryName: String) {
        super.init()
        _categoryName.accept(categoryName)
        bind()
        // FIXME: - mock데이터 삭제
        roadDatas.accept(["1","1","1","1"])
        categoryWords.accept(["가가가가나나나나다다다다라라라라","12","13","14","12345","하하하하하하하하하하ㅏ"])
    }
    
    private func bind() {
        _categoryName
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                // TODO: 카테고리 통신
                print("기능처리")
                self?.categoryName.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
