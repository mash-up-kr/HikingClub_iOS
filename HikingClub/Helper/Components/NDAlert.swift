//
//  NDAlert.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

/**
 - Note: 딤처리 뷰가 있어서 레이아웃을 eqaulToSuperView로 잡을 것
 */
final class NDAlert: UIView, CodeBasedProtocol {
    enum ButtonStyle {
        case one
        case two
    }
    
    private let dimView: UIView = UIView()
    private let containerView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    fileprivate var ndButtons: NDButtons?
    fileprivate var ndButton: NDButton?
    private let disposeBag: DisposeBag = DisposeBag()
    private var buttonStyle: ButtonStyle = .one
    
    init(buttonStyle: NDAlert.ButtonStyle,
         title: String?,
         description: String?,
         okTitle: String?,
         okHandler: (() -> Void)?,
         cancelTitle: String?,
         cancelHandler: (() -> Void)?) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        descriptionLabel.text = description
        self.buttonStyle = buttonStyle
        
        addSubViews(dimView, containerView)
        switch buttonStyle {
        case .one:
            ndButton = NDButton(theme: .init(.fillGreen))
            ndButton?.setTitle(okTitle, for: .normal)
            ndButton?.rx.tap
                .subscribe(onNext: { [weak self] in
                    okHandler?()
                    self?.removeFromSuperview()
                })
                .disposed(by: disposeBag)
            containerView.addSubViews(titleLabel, descriptionLabel, ndButton!)
        case .two:
            ndButtons = NDButtons(okTitle: okTitle, cancelTitle: cancelTitle)
            ndButtons?.rx.okTap
                .subscribe(onNext: { [weak self] in
                    okHandler?()
                    self?.removeFromSuperview()
                })
                .disposed(by: disposeBag)
            
            ndButtons?.rx.cancelTap
                .subscribe(onNext: { [weak self] in
                    cancelHandler?()
                    self?.removeFromSuperview()
                })
                .disposed(by: disposeBag)
            containerView.addSubViews(titleLabel, descriptionLabel, ndButtons!)
        }
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(295)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        switch buttonStyle {
        case .one:
            ndButton?.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.bottom.equalToSuperview().inset(16)
                $0.height.equalTo(54)
            }
        case .two:
            ndButtons?.snp.makeConstraints {
                $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
                $0.leading.equalToSuperview().offset(16)
                $0.trailing.bottom.equalToSuperview().inset(16)
                $0.height.equalTo(54)
            }
        }
    }
    
    func attribute() {
        dimView.backgroundColor = .gray900
        dimView.alpha = 0.5
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }
}
