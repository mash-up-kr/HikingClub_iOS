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
    let categoryWords: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    private let userDefaultManager: UserDefaultManager = UserDefaultManager()
    
    override init() {
        super.init()
        bind()
    }
    
    func removeAllRecentSearchWords() {
        recentSearchWords.accept([])
    }
    
    func removeRecentSearchWord(at index: Int) {
        var currentWords = recentSearchWords.value
        currentWords.remove(at: index)
        let newWords = currentWords
        recentSearchWords.accept(newWords)
    }
    
    func bind() {
        UserDefaults.standard.rx
            .observe([String].self, UserDefaults.Name.recentSearch.rawValue)
            .debug()
            .distinctUntilChanged()
            .compactMap { element -> [String] in element?.reversed() ?? [] }
            .bind(to: recentSearchWords)
            .disposed(by: disposeBag)
    }
    
    func saveRecentWords(_ word: String, key: UserDefaults.Name) {
        if userDefaultManager.isEmpty(key: key) {
            userDefaultManager.save([word], key: key)
        } else {
            guard var currentWords: [String] = userDefaultManager.value(key: key) else {
                return
            }
            
            if currentWords.contains(word),
               let index: Int = currentWords.firstIndex(of: word) {
                currentWords.remove(at: index)
            }
            currentWords.append(word)
            
            let newWords: [String] = currentWords
            userDefaultManager.save(newWords, key: key)
        }
    }
}
