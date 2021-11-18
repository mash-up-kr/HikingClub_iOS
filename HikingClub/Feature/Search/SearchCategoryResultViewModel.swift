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
    let roadDatas: BehaviorRelay<[Road]> = BehaviorRelay(value: [])
    let categoryWords: BehaviorRelay<[CategoryModel]>
    let currentCategory: BehaviorRelay<CategoryModel>
    
    // MARK: - Input
    let selectedCategory: BehaviorRelay<Int>
    
    init(selectedIndex: Int, categories: [CategoryModel]) {
        categoryWords = BehaviorRelay(value: categories)
        selectedCategory = BehaviorRelay(value: selectedIndex)
        currentCategory = BehaviorRelay(value: categories[selectedIndex])
        super.init()
        bind()
    }
    
    private func bind() {
        selectedCategory
            .filter { [weak self] in 0 <= $0 && $0 < self?.categoryWords.value.count ?? 0 }
            .subscribe(onNext: { [weak self] index in
                guard let category = self?.categoryWords.value[index] else { return }
                self?.currentCategory.accept(category)
            })
            .disposed(by: disposeBag)
    }
}
