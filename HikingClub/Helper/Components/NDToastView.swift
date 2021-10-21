//
//  NDToastView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/21.
//

import UIKit

final class NDToastView: UIView, CodeBasedProtocol {
    enum Theme {
        case green
        case red
    }
    private let iconImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    init(theme: Theme) {
        super.init(frame: .zero)
        switch theme {
        case .green:
            backgroundColor = .green500
            iconImageView.image = UIImage(named: "Pin")
        case .red:
            backgroundColor = .red500
            iconImageView.image = UIImage(named: "Pin")
        }
        layout()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        addSubViews(iconImageView, titleLabel)
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(iconImageView)
        }
    }
    
    func attribute() {
        titleLabel.setFont(.semiBold16)
        titleLabel.textColor = .white
        layer.cornerRadius = 8
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
