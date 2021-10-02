//
//  RoadTableViewCell.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit

class RoadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roadImageView: UIImageView!
    @IBOutlet weak var roadTitleLabel: UILabel!
    @IBOutlet weak var roadBookMarkImageView: UIImageView!
    @IBOutlet weak var roadDistanceLabel: UILabel!
    @IBOutlet weak var roadSpotLabel: UILabel!
    @IBOutlet weak var roadAddressLabel: UILabel!
    @IBOutlet weak var roadHashTagStackView: UIStackView!
    @IBOutlet weak var roadTitleLabelTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roadTitleLabel.setFont(.bold16)
        roadDistanceLabel.setFont(.semiBold13)
        roadSpotLabel.setFont(.semiBold11)
        roadAddressLabel.setFont(.semiBold13)
        
    }
    
    func settingRoadHashTagStackView(_ tags: [String]) {
        roadHashTagStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        let maxCount = min(tags.count, 3)
        for i in 0..<maxCount {
            let tagView = RoadHashTagView()
            tagView.setText(tags[i])
            roadHashTagStackView.addArrangedSubview(tagView)
        }
        
        if tags.count > 3 {
            let label = UILabel()
            label.text = "\(tags.count - 3)"
            label.setFont(.medium14)
            roadHashTagStackView.addArrangedSubview(label)
        }
    }
}
