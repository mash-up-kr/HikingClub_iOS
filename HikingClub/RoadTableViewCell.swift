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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
