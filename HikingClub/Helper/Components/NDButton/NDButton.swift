//
//  NDButton.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/09.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

/// 노들길 버튼 템플릿
class NDButton: UIView {
    fileprivate let button: UIButton = UIButton(type: .system)
    var theme: NDButtonTheme = NDButtonTheme(.fillGreen) {
        didSet { setTheme(theme) }
    }
    var isEnabled: Bool {
        get { button.isEnabled }
        set { setEnable(newValue) }
    }
    
    init(theme: NDButtonTheme) {
        self.theme = theme
        super.init(frame: .zero)
        configureUI()
        setTheme(theme)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        setTheme(theme)
    }
    
    private func configureUI() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setTitle(_ title: String?, for state: UIControl.State) {
        button.setTitle(title, for: state)
    }
    
    private func setTheme(_ theme: NDButtonTheme) {
        backgroundColor = theme.backgroundColor
        layer.borderWidth = theme.borderWidth ?? 0
        layer.borderColor = theme.borderColor?.cgColor ?? UIColor.black.cgColor
        layer.cornerRadius = theme.radius
        button.layer.cornerRadius = theme.radius
        button.setTitleColor(theme.textColor, for: .normal)
        button.setFont(theme.font)
    }
    
    /// Enable상태에 따라서 배경색도 같이변경
    fileprivate func setEnable(_ isEnabled: Bool) {
        backgroundColor = isEnabled ? theme.backgroundColor : theme.backgroundColor.disable
        button.isEnabled = isEnabled
    }
}

// MARK: - Rx

extension Reactive where Base: NDButton {
    var tap: ControlEvent<Void> {
        base.button.rx.tap
    }
    
    var isEnabled: Binder<Bool> {
        Binder(base) { $0.setEnable($1) }
    }
}

