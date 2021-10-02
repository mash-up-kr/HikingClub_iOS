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
    }
    
    func configureUI() {
        hitThemeLabel.setFont(.semiBold16)
        currentLocationButton.semanticContentAttribute = .forceRightToLeft
        currentLocationButton.setTitle("현위치", for: .normal)
        currentLocationButton.setFont(.semiBold20)
        currentLocationButton.setImage(UIImage(named: "downArrow"), for: .normal)
    }
}
