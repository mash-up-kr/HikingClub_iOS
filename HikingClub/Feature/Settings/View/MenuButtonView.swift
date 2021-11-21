//
//  MenuButtonView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/03.
//

import UIKit

final class MenuButtonView: UIButton, CodeBasedProtocol {
    enum MenuType {
        case town
        case personlInformation
        case version
        case notice
        case inquiry
        case signOut
        case withdraw
        case opensource
    }
    
    private let iconImageView = UIImageView()
    
    private let contentStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 13
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold16)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let subContentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.medium12)
        label.textColor = .gray500
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private var menuType: MenuType
    
    init(_ type: MenuType) {
        menuType = type
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Attribute
    
    func attribute() {
        attributeForType()
    }
    
    private func attributeForType() {
        var title: String = ""
        var subTitle: String? = nil
        var icon: AssetImage? = nil
        
        switch menuType {
        case .town:
            title = "동네 / 카테고리"
            icon = .icon_my_2location_normal_gray900_24
        case .personlInformation:
            title = "개인정보 설정"
            icon = .icon_my_lock_normal_gray900_24
        case .version:
            title = "버전 정보"
            icon = .icon_my_info_normal_gray900_24
            subTitle = "v.1.5"
        case .notice:
            title = "공지사항"
            icon = .icon_my_loudspeaker_normal_gray900_24
        case .inquiry:
            title = "문의하기"
            icon = .icon_my_question_normal_gray900_24
        case .signOut:
            title = "로그아웃"
            icon = .icon_my_unlock_normal_gray900_24
        case .withdraw:
            title = "탈퇴하기"
            icon = .icon_my_trash_normal_gray900_24
        case .opensource:
            title = "오픈소스"
            icon = .icon_my_machine_tool_normal_gray900_24
        }
        
        contentLabel.text = title
        if subTitle == nil {
            subContentLabel.isHidden = true
        }
        subContentLabel.text = subTitle
        guard let assetImage = icon else { return }
        iconImageView.setImage(assetImage)
    }
    
    // MARK: - Layout
    
    func layout() {
        addSubViews(iconImageView, contentStackView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
            
            $0.width.height.equalTo(24)
        }
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().inset(15)
        }
        contentStackView.addArrangedSubviews(contentLabel, subContentLabel)
    }
    
}

