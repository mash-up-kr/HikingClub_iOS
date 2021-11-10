//
//  CategoryCollectionView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/08.
//

import UIKit

/// 카테고리 컬랙션 뷰
final class CategoryCollectionView: UICollectionView {
    static let cellIdentifier = "CategoryCollectionViewCell"
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let margin: CGFloat = 16
        let width = ((UIScreen.main.bounds.width - margin * 2) - (spacing * 2)) / 3
        let height = 96 * width / 109
        layout.itemSize = .init(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        self.init(frame: .zero, collectionViewLayout: layout)
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
        register(CategoryCollectionViewCell.self)
    }
    
    /// - Note: 카테고리 내용변경시 호출
    /// - 컬랙션뷰 자체높이 재계산
    func updateCollectionViewHeight() {
        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let dataCount = self.numberOfItems(inSection: 0)
        let row: CGFloat = CGFloat((dataCount + 2) / 3)
        let spacing = layout.minimumInteritemSpacing
        let itemHeight = layout.itemSize.height
        let height = itemHeight * row + spacing * (row - 1)
        self.snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}
