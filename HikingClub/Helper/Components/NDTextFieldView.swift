//
//  NDTextFieldView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

/// - Note: minHeight: 94 maxHeight: 102
/// - `setTitle()`후에 `setTheme()`를 호출해주면 테마가 잘 적용됩니다
final class NDTextFieldView: UIView {
    enum Theme {
        /// 초록색 강조
        case highlight
        /// 빨간색 강조
        case warning
        /// 직접입력 불가능하고 선택으로 입력가능
        case selected
        case normal
    }
    
    enum Scale: CGFloat {
        case small = 48
        case big = 56
    }
    
    private let titleLabel: UILabel = UILabel()
    fileprivate let textField: UITextField = UITextField()
    private let descriptionLabel: UILabel = UILabel()
    fileprivate let detailButton: UIButton = UIButton(type: .system)
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var scale: Scale = .small
    private var titles: [Theme: String?] = [:]
    private var descriptions: [Theme: String?] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    init(scale: Scale) {
        super.init(frame: .zero)
        self.scale = scale
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        layer.cornerRadius = 8
        textField.addLeftPadding(16)
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.gray100.cgColor
        textField.layer.borderWidth = 1.2
        textField.setPlaceholder(font: .semiBold16, color: .gray300)
        textField.setFont(.semiBold16)
        textField.backgroundColor = .gray50
        textField.textColor = .gray800
        
        titleLabel.setFont(.semiBold13)
        titleLabel.textColor = .gray700
        titleLabel.isHidden = true
        
        descriptionLabel.setFont(.medium12)
        descriptionLabel.textColor = .gray500
        descriptionLabel.isHidden = true
        detailButton.isHidden = true
        
        configureLayout()
    }
    
    private func configureLayout() {
        addSubViews(titleLabel, textField, descriptionLabel, detailButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(scale.rawValue)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(8)
            $0.leading.bottom.equalToSuperview()
        }
        
        detailButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.trailing.equalTo(textField).inset(16)
        }
    }
    
    func setTheme(_ theme: Theme) {
        titleLabel.isHidden = titles[theme] == nil
        descriptionLabel.isHidden = descriptions[theme] == nil
        titleLabel.text = titles[theme] ?? nil
        descriptionLabel.text = descriptions[theme] ?? nil
        
        switch theme {
        case .highlight:
            descriptionLabel.textColor = .green500
            textField.layer.borderColor = UIColor.green500.cgColor
            textField.textColor = .gray800
        case .warning:
            descriptionLabel.textColor = .red500
            textField.layer.borderColor = UIColor.red500.cgColor
            textField.textColor = .red500
        case .selected:
            detailButton.isHidden = false
            detailButton.setImage(.icon_textField_angleBracket_right_gray600_24)
            textField.isUserInteractionEnabled = false
            fallthrough
        case .normal:
            descriptionLabel.textColor = .gray500
            textField.layer.borderColor = UIColor.gray100.cgColor
            textField.textColor = .gray800
        }
    }
    
    /// 텍스트필드 상황별 설정
    func setTitle(_ title: String? = nil, description: String? = nil, theme: Theme = .normal) {
        titles[theme] = title
        descriptions[theme] = description
    }
    
    func setPlaceholder(_ placeholder: String?) {
        textField.placeholder = placeholder
    }
    
    func setDetailButton(_ isHidden: Bool) {
        detailButton.isHidden = isHidden
    }
}

// MARK: - Rx

extension Reactive where Base: NDTextFieldView {
    var text: ControlProperty<String> {
        base.textField.rx.text.orEmpty
    }
    
    var tapDetailButton: ControlEvent<Void> {
        base.detailButton.rx.tap
    }
    
    var theme: Binder<NDTextFieldView.Theme> {
        Binder(base) { base, value in
            base.setTheme(value)
        }
    }
}
