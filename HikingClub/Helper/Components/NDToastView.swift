//
//  NDToastView.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/21.
//

import UIKit
import RxSwift
import RxCocoa

final class NDToastView: UIView, CodeBasedProtocol {
    static let shared: NDToastView = NDToastView()
    
    enum Theme {
        case green(text: String)
        case red(text: String)
    }
    private let iconImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private lazy var showAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.6) { [weak self] in
        self?.transform = .init(translationX: 0, y: 100)
    }
    private var isPresent: Bool = false
    
    private init() {
        super.init(frame: .zero)
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
    
    func setTheme(_ theme: Theme) {
        switch theme {
        case let .green(text):
            backgroundColor = .green500
            iconImageView.image = UIImage(named: "Pin")
            titleLabel.text = text
        case let .red(text):
            backgroundColor = .red500
            iconImageView.image = UIImage(named: "Pin")
            titleLabel.text = text
        }
    }
    
    fileprivate func showToast() {
        if isPresent {
            return
        }
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
                  fatalError("not exist window")
              }
        
        window.addSubview(self)
        self.snp.makeConstraints {
            $0.width.equalTo(343)
            $0.height.equalTo(48)
            $0.bottom.equalTo(window.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        isPresent = true
        showAnimation.pausesOnCompletion = true
        showAnimation.addObserver(self, forKeyPath: "running", options: [.new], context: nil)
        showAnimation.startAnimation()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIViewPropertyAnimator.isRunning){
            if !isPresent {
                removeFromSuperview()
                showAnimation.removeObserver(self, forKeyPath: "running")
            }
            if showAnimation.fractionComplete == 1.0 {
                showAnimation.isReversed = !showAnimation.isReversed
                showAnimation.startAnimation()
                isPresent = false
            }
        }
    }
}

extension Reactive where Base: NDToastView {
    var showText: Binder<NDToastView.Theme> {
        Binder(base) {
            $0.setTheme($1)
            $0.showToast()
        }
    }
}
