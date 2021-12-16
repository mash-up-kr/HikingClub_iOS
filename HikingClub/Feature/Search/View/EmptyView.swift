//
//  EmptyView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/14.
//

import UIKit
import SnapKit
import RxSwift

/// emptyView
final class EmptyView: CodeBasedView {
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setImage(.img_empty)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private var title: String {
        if NDLocationManager.shared.locationAuthStatus == .denied {
            return "현재위치 기반 검색 결과가 없습니다.\n\n위치 접근 권한을 확인하시거나\n상단의 테마 리스트를 확인해 보세요."
        } else {
            return "현재 위치에 등록된 게시물이 없습니다.\n상단의 테마 리스트를 확인해 보세요."
        }
    }
    
    override func attribute() {
        super.attribute()
        backgroundColor = .white
        updateComment()
    }
    
    override func layout() {
        super.layout()
        addSubViews(emptyImageView, titleLabel)
        
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func updateComment(_ isEmptyData: Bool = false) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.alignment = .center
        
        let titleText: String = isEmptyData ? "현재 위치에 등록된 게시물이 없습니다.\n상단의 테마 리스트를 확인해 보세요." : title
        
        titleLabel.attributedText = NSAttributedString(
            string: titleText,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.ndFont(type: .semiBold18),
                .foregroundColor: UIColor.gray700
            ]
        )
    }
}
