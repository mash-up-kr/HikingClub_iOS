//
//  HitThemeTableHeaderView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/02.
//

import UIKit

final class HitThemeTableHeaderView: UIView {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setCollectionView()
    }
    
    func configureUI() {
        iconImageView.setImage(.logo_gray)
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(HitThemeHeaderCollectionViewCell.self)
    }
}

// TODO: - 데이터모델만들고 rx로 변환하기
extension HitThemeTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HitThemeHeaderCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}

extension HitThemeTableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 144, height: 104)
    }
}

extension HitThemeTableHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 클릭시 화면이동
        print("\(#function) select: \(indexPath)")
    }
}
