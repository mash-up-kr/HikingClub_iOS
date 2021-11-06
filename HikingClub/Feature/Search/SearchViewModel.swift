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
    
    func removeAllRecentSearchWords() {
        recentSearchWords.accept([])
    }
    
    func removeRecentSearchWord(at index: Int) {
        var currentWords = recentSearchWords.value
        currentWords.remove(at: index)
        let newWords = currentWords
        recentSearchWords.accept(newWords)
        print(index)
    }
}
