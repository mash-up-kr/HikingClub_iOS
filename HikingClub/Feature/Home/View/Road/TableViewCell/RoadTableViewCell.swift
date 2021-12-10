//
//  RoadTableViewCell.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/02.
//

import UIKit
import Kingfisher

final class RoadTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleStackView: UIStackView!
    @IBOutlet private weak var roadImageView: UIImageView!
    @IBOutlet private weak var roadTitleLabel: UILabel!
    @IBOutlet private weak var roadBookMarkButton: UIButton!
    @IBOutlet private weak var roadDistanceLabel: UILabel!
    @IBOutlet private weak var roadSpotBackgroundView: UIView!
    @IBOutlet private weak var roadSpotLabel: UILabel!
    @IBOutlet private weak var roadAddressLabel: UILabel!
    @IBOutlet private weak var roadHashTagStackView: UIStackView!
    @IBOutlet private weak var roadHashTagStackViewWidth: NSLayoutConstraint!
    @IBOutlet private weak var roadLikeBadgeView: UIView!

    var model: Road?
    private let walkCalculator = WalkCalculator()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hiddenView()
        customText()
        customBackground()
        customCornerRadius()
        setRoadImageViewHidden(true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        roadImageView.image = nil
        setRoadImageViewHidden(true)
    }
    
    func configure(model: Road) {
        self.model = model
        roadTitleLabel.text = model.title
        setRoadDistanceLabel(distance: model.distance)
        roadSpotLabel.text = "\(model.spots.count)개의 스페셜 스팟"
        roadAddressLabel.text = model.place
        
        if let imageString = model.images.first,
        let imageURL = URL(string: imageString) {
            setRoadImageViewHidden(false)
            roadImageView.kf.indicatorType = .activity
            roadImageView.kf.setImage(with: imageURL, options: [.cacheOriginalImage]) { _ in
                
            }
        }
        
        settingRoadHashTagStackView(model.hashtags)
    }
    
    private func setRoadDistanceLabel(distance: Float) {
        let time = walkCalculator.costTime(distance: distance)
        let hour = time / 60
        let min = time % 60
        
        if time > 60 {
            roadDistanceLabel.text = "\(distance)km (\(hour)시간 \(min)분)"
        } else if time == 60 {
            roadDistanceLabel.text = "\(distance)km (\(hour)시간"
        } else {
            roadDistanceLabel.text = "\(distance)km (\(time)분)"
        }
    }
    
    private func setRoadImageViewHidden(_ isHidden: Bool) {
        roadImageView.isHidden = isHidden
        titleStackView.spacing = isHidden ? 0 : 17
    }
    
    private func settingRoadHashTagStackView(_ tags: [String]) {
        roadHashTagStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        // 테그 3개를 가져와서 순서대로 View 반환
        let maxCount = min(tags.count, 3)
        let spacing: CGFloat = 4
        var width: CGFloat = CGFloat(maxCount-1) * spacing
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
            width += label.frame.width + spacing
            roadHashTagStackView.addArrangedSubview(label)
        }
        roadHashTagStackViewWidth.constant = width
    }
}
//MARK: UICoustomize
extension RoadTableViewCell {
    
    private func customCornerRadius() {
        roadImageView.layer.cornerRadius = 8
        roadSpotBackgroundView.layer.cornerRadius = 4
    }
    
    private func customBackground() {
        roadSpotBackgroundView.backgroundColor = .green50
    }
    
    private func customText() {
        roadTitleLabel.setFont(.semiBold16)
        roadTitleLabel.textColor = .gray900
        roadDistanceLabel.setFont(.semiBold13)
        roadDistanceLabel.textColor = .green700
        roadSpotLabel.setFont(.semiBold11)
        roadSpotLabel.textColor = .green700
        roadAddressLabel.setFont(.semiBold13)
        roadAddressLabel.textColor = .gray600
    }
}
//MARK: SomeViewHidden
extension RoadTableViewCell {
    
    func hiddenView() {
        roadBookMarkButton.isHidden = true
        roadLikeBadgeView.isHidden = true
    }
}
