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
    
    private let placeService = PlaceService()
    
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
                self?.requestRoad(id: category.id)
            })
            .disposed(by: disposeBag)
    }
    
    /// 카테고리별 리스트 조회
    func requestRoad(id: Int) {
        let model = PlaceRequestModel.RoadListModel(categoryId: id , lastId: "", direction: .forward)
        placeService.roads(model: model)
            .compactMap { $0.data?.roads.map { Road(road: $0) } }
            .subscribe(onSuccess: { [weak self] in
                self?.roadDatas.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
