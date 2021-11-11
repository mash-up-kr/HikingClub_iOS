//
//  HitThemeTableHeaderView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/02.
//

import UIKit

final class HitThemeTableHeaderView: UIView {
    @IBOutlet private weak var hitThemeLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setCollectionView()
    }
    
    func configureUI() {
        hitThemeLabel.text = "인기 테마"
        hitThemeLabel.setFont(.semiBold20)
        hitThemeLabel.textColor = .gray900
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.register(HitThemeHeaderCollectionViewCell.self)
    }
}

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
