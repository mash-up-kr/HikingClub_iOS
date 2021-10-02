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
        
    }
}
