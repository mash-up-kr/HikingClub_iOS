//
//  ComponentTestViewController.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/15.
//

import UIKit

final class ComponentTestViewController: UIViewController {

    let ndTextFieldView = NDTextFieldView(scale: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        ndTextFieldView.setPlaceholder("플레이스 홀더")
        ndTextFieldView.setTitle("레이블", description: "설명이 들어갑니다")
        view.addSubview(ndTextFieldView)
        ndTextFieldView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.leading.equalToSuperview()
        }
        
        ndTextFieldView.rx.theme.onNext(.warning)
    }
}
