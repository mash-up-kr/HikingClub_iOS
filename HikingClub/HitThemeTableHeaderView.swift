//
//  HitThemeTableHeaderView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/02.
//

import UIKit

final class HitThemeTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var hitThemeLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var currentLocationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        setCollectionView()
    }
    
    func configureUI() {
        hitThemeLabel.setFont(.semiBold16)
        currentLocationButton.semanticContentAttribute = .forceRightToLeft
        currentLocationButton.setTitle("현위치", for: .normal)
        currentLocationButton.setFont(.semiBold20)
        currentLocationButton.setImage(UIImage(named: "downArrow"), for: .normal)
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
    }
}

extension HitThemeTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HitThemeHeaderCollectionViewCell", for: indexPath)
        return cell
    }
}
