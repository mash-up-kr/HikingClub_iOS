//
//  MyPageListHeaderButtonView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/03.
//

import UIKit
import RxRelay
import RxSwift

final class MyPageListHeaderButtonView: CodeBasedView {
    enum ButtonType {
        case myList
        case savedList
    }
    
    private var currentSelectedButton: ButtonType = .myList
    
    private let myListButton: UIButton = {
        let button = MyPageListHeaderButton("나의 길")
        return button
    }()
    
    private let savedListButton: UIButton = {
        let button = MyPageListHeaderButton("저장한 길")
        return button
    }()
    
    let currentSelctedRelay = PublishRelay<ButtonType>()
    
    private let disposeBag = DisposeBag()
    
    override func attribute() {
        super.attribute()
    }
    
    override func layout() {
        addSubViews(myListButton, savedListButton)
        myListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        savedListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(myListButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        myListButton.rx.tap
            .bind { [weak self] in self?.setSelected(.myList) }
            .disposed(by: disposeBag)
        
        savedListButton.rx.tap
            .bind { [weak self] in self?.setSelected(.savedList) }
            .disposed(by: disposeBag)
    }

    func setSelected(_ type: ButtonType) {
        switch type {
        case .myList:
            myListButton.isSelected = true
            savedListButton.isSelected = false
        case .savedList:
            myListButton.isSelected = false
            savedListButton.isSelected = true
        }
    }
}
