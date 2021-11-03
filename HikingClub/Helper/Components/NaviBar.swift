//
//  NaviBar.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/14.
//

import UIKit
import RxSwift
import RxCocoa

/**
 사용시 높이는 지정안해도되고 **좌우상단만** 잡아주세요
 **스토리보드는 예외**
 ``` swift
 testNavi.snp.makeConstraints {
     $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
 }
 ```
 */
final class NaviBar: UIView {
    fileprivate let leftButton: UIButton = UIButton(type: .system)
    /// - Note: 오른쪽 아이템 사용시 Hidden끄고 사용하세요
    fileprivate let rightButton: UIButton = UIButton(type: .system)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold16)
        label.textColor = .gray700
        return label
    }()
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray100
        return view
    }()
    private let naviHeight: CGFloat = 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubViews(titleLabel, leftButton, rightButton, dividerView)
        rightButton.isHidden = true
        leftButton.isHidden = true
        configureLayout()
    }
    
    private func configureLayout() {
        self.snp.updateConstraints {
            $0.height.equalTo(naviHeight)
        }
        
        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    /// 오른쪽버튼버튼 설정
    func setRightItemImage(_ asset: AssetImage) {
        rightButton.setImage(asset)
        rightButton.isHidden = false
    }
    
    /// 백버튼 설정
    func setBackItemImage() {
        leftButton.setImage(.icon_angleBracket_left_gray900_24)
        leftButton.tintColor = .gray900
        leftButton.isHidden = false
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    /// 네비게이션 하단 구분선 히든설정
    func setDividerHidden(_ isHidden: Bool) {
        dividerView.isHidden = isHidden
    }
}

// MARK: - Rx

extension Reactive where Base: NaviBar {
    var tapLeftItem: ControlEvent<Void> {
        base.leftButton.rx.tap
    }
    
    var tapRightItem: ControlEvent<Void> {
        base.rightButton.rx.tap
    }
    
    var title: Binder<String> {
        Binder(base) { $0.setTitle($1) }
    }
}
