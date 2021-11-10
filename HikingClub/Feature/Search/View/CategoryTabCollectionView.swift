//
//  CategoryTabCollectionView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/08.
//

import UIKit

/// 상단탭바 컬랙션 뷰
/// - Note: cellSize를 이용해서 편리하게 계산가능
/// - 최소높이 33
final class CategoryTabCollectionView: UICollectionView {
    static let cellIdentifier = "CategoryTabCollectionViewCell"
    
    convenience init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = .zero
        self.init(frame: .zero, collectionViewLayout: flowLayout)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        backgroundColor = .gray100
        register(CategoryTabCollectionViewCell.self)
    }
    
    /// 텍스트 길이에 맞는 셀크기 반환
    func cellSize(text: String) -> CGSize {
        let tab: NDTabButton = {
            let tab = NDTabButton()
            tab.setTitle(text)
            return tab
        }()
        tab.layoutIfNeeded()
        return CGSize(width: tab.bounds.width, height: 33)
    }
}
