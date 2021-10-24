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
    @IBOutlet weak var roadBookMarkButton: UIButton!
    @IBOutlet weak var roadDistanceLabel: UILabel!
    @IBOutlet weak var roadSpotBackgroundView: UIView!
    @IBOutlet weak var roadSpotLabel: UILabel!
    @IBOutlet weak var roadAddressLabel: UILabel!
    @IBOutlet weak var roadHashTagStackView: UIStackView!
    @IBOutlet weak var roadHashTagStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var roadLikeBadgeView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        hiddenView()
        
        roadImageView.layer.cornerRadius = 8
        roadSpotBackgroundView.layer.cornerRadius = 4
        
        roadTitleLabel.setFont(.bold16)
        roadDistanceLabel.setFont(.semiBold13)
        roadSpotLabel.setFont(.semiBold11)
        roadAddressLabel.setFont(.semiBold13)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 0, bottom: 4, right: 0))
    }
    
    func configure(tags: [String]) {
        settingRoadHashTagStackView(tags)
        setRoadTitleLabelTopConstraint()
    }
    
    // label width로 잡음, 코드로 stackView 짜는거 찾아보기
    private func settingRoadHashTagStackView(_ tags: [String]) {
        roadHashTagStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let maxCount = min(tags.count, 3)
        var width: CGFloat = 0
        for i in 0..<maxCount {
            let tagView = RoadHashTagView()
            width += tagView.setText(tags[i])
            print("📌\(width)")
            roadHashTagStackView.addArrangedSubview(tagView)
        }
        
        if tags.count > 3 {
            let label = UILabel()
            label.text = "+\(tags.count - 3)"
            label.setFont(.medium14)
            label.sizeToFit()
            width += label.frame.width
            roadHashTagStackView.addArrangedSubview(label)
        }
        roadHashTagStackViewWidth.constant = width
    }
    
    private func setRoadTitleLabelTopConstraint() {
        roadImageView.isHidden = true
        if roadImageView.image == nil {
            roadImageView.isHidden = true
            
        } else {
            roadImageView.isHidden = false
            
        }
    }
}

extension RoadTableViewCell {
    
    func hiddenView() {
        roadBookMarkButton.isHidden = true
        roadLikeBadgeView.isHidden = true
    }
}
