//
//  RoadTableViewCell.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit

class RoadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleStackView: UIStackView!
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
        // 북마크, 좋아요 뱃지 히든처리
        hiddenView()
        // 이미지, 스페셜 스팟 cornerRadius적용
        roadImageView.layer.cornerRadius = 8
        roadSpotBackgroundView.layer.cornerRadius = 4
        // UIView Color적용
        roadSpotBackgroundView.backgroundColor = .green50
        // fontSize, color 적용
        roadTitleLabel.setFont(.semiBold16)
        roadTitleLabel.textColor = .gray900
        roadDistanceLabel.setFont(.semiBold13)
        roadDistanceLabel.textColor = .green700
        roadSpotLabel.setFont(.semiBold11)
        roadSpotLabel.textColor = .green700
        roadAddressLabel.setFont(.semiBold13)
        roadAddressLabel.textColor = .gray600
    }
    
    func configure(tags: [String]) {
        settingRoadHashTagStackView(tags)
        setRoadTitleLabelTopConstraint()
        titleStackView.spacing = roadImageView.image == nil ? 0 : 14
    }
    
    private func settingRoadHashTagStackView(_ tags: [String]) {
        roadHashTagStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        // 테그 3개를 가져와서 순서대로 View 반환
        let maxCount = min(tags.count, 3)
        var width: CGFloat = 0
        for i in 0..<maxCount {
            let tagView = RoadHashTagView()
            width += tagView.setText(tags[i])
            roadHashTagStackView.addArrangedSubview(tagView)
        }
        // 생성된 뷰에 label주입, 폰트 적용, width 재설정
        if tags.count > 3 {
            let label = UILabel()
            label.text = "+\(tags.count - 3)"
            label.setFont(.medium14)
            label.textColor = .gray500
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
