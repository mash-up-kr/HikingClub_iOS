//
//  OpensourceLicenseViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/12/05.
//

import UIKit

final class OpensourceLicenseViewController: BaseViewController<BaseViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar()
        view.setTitle("오픈소스 라이센스")
        view.setBackItemImage()
        
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        
        guard let filePath = Bundle.main.path(forResource: "license", ofType: "rtf") else {
            return textView
        }
        
        let opensourceTextFileURL = URL(fileURLWithPath: filePath)
        
        do {
            let opensourceText = try NSAttributedString(
                url: opensourceTextFileURL,
                options: [:],
                documentAttributes: nil
            )
            textView.attributedText = opensourceText
        } catch { }
    
        return textView
    }()
        
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, textView)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    override func bind() {
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
