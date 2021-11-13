//
//  SearchViewModel.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/27.
//

import Foundation
import RxRelay

final class SearchViewModel: BaseViewModel {
    // MARK: - Input
    
    // MARK: - Output
    /// 최근검색어
    let recentSearchWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    /// 카테고리
    let categoryWords: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    
    // MARK: - Property
    private let userDefaultManager: RecentSearchUserDefault = RecentSearchUserDefault(key: .recentSearch)
    private let placeService = PlaceService()
    let error: PublishRelay<NetworkError> = PublishRelay()
    
    override init() {
        super.init()
        bind()
        requestCategories()
    }
    
    func bind() {
        UserDefaults.standard.rx
            .observe([String].self, UserDefaults.Name.recentSearch.rawValue)
            .debug()
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind(to: recentSearchWords)
            .disposed(by: disposeBag)
    }
    
    /// 카테고리 리스트
    func requestCategories() {
        placeService.categories()
            .subscribe(onSuccess: { [weak self] in
                self?.categoryWords.accept($0.listData)
            })
            .disposed(by: disposeBag)
    }
    
    /// 전체삭제
    func removeAllRecentSearchWords() {
        if recentSearchWords.value.isEmpty {
            return
        }
        userDefaultManager.removeAll()
    }
    
    /// 검색어 개별 삭제
    func removeRecentSearchWord(at index: Int) {
        print("삭제: \(recentSearchWords.value)")
        var currentWords: [String] = recentSearchWords.value
        currentWords.remove(at: index)
        let newWords = currentWords
        userDefaultManager.save(newWords)
    }
    
    /// 검색어 저장
    func saveRecentWords(_ word: String) {
        if userDefaultManager.isEmpty {
            userDefaultManager.save([word])
        } else {
            var currentWords: [String] = recentSearchWords.value
            if currentWords.contains(word),
               let index: Int = currentWords.firstIndex(of: word) {
                currentWords.remove(at: index)
            }
            currentWords.insert(word, at: 0)
            let newWords: [String] = currentWords
            userDefaultManager.save(newWords)
        }
    }
}
