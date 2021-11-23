//
//  NDIndicator.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/23.
//

import UIKit
import RxSwift

// TODO: 추후에 이쁘게 꾸며보자..!
final class NDIndicator: CodeBasedView {
    static let shared: NDIndicator = NDIndicator()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .green700
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func attribute() {
        super.attribute()
        backgroundColor = .gray200.withAlphaComponent(0.7)
        layer.cornerRadius = 10
    }
    
    override func layout() {
        super.layout()
        
        addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func show() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
                  fatalError("not exist window")
              }
        window.addSubview(self)
        self.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        indicator.startAnimating()
    }
    
    func hide() {
        indicator.stopAnimating()
        self.removeFromSuperview()
    }
}
